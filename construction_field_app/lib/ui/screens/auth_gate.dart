import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';
import 'role_selection_screen.dart';
import 'project_list_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AuthService(AuthRepository());

    return FutureBuilder<bool>(
      future: service.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!) {
          return LoginScreen(); // not logged in
        }

        return FutureBuilder<String?>(
          future: service.getRole(),
          builder: (context, roleSnapshot) {
            if (roleSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!roleSnapshot.hasData || roleSnapshot.data == null) {
              return RoleSelectionScreen(); // role not selected
            }

            // Logged in + role selected → project selection
            return ProjectListScreen();
          },
        );
      },
    );
  }
}
