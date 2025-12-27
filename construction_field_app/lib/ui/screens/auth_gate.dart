import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import 'login_screen.dart';
import 'role_selection_screen.dart';
import 'main_scaffold.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AuthService(AuthRepository());

    return FutureBuilder<bool>(
      future: service.isLoggedIn(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.data!) {
          return LoginScreen(); // ✅ no const
        }

        return FutureBuilder<String?>(
          future: service.getRole(),
          builder: (context, roleSnapshot) {
            if (!roleSnapshot.hasData) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (roleSnapshot.data == null) {
              return RoleSelectionScreen(); // ✅ no const
            }

            return MainScaffold(); // ✅ no const
          },
        );
      },
    );
  }
}
