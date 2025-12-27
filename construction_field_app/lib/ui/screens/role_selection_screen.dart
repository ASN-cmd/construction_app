import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import 'main_scaffold.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AuthService(AuthRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Role'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          roleButton(context, service, 'Site Engineer'),
          roleButton(context, service, 'Supervisor'),
          roleButton(context, service, 'Manager'),
        ],
      ),
    );
  }

  Widget roleButton(
      BuildContext context, AuthService service, String role) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(250, 50),
        ),
        onPressed: () async {
          await service.saveRole(role);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainScaffold()),
            (route) => false,
          );

        },
        child: Text(role),
      ),
    );
  }
}

