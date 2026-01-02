import 'package:flutter/material.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import 'project_list_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = AuthService(AuthRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            RoleCard(
              icon: Icons.engineering,
              title: 'Site Engineer',
              onTap: () async {
                await service.saveRole('Site Engineer');
                _goToProjects(context);
              },
            ),
            RoleCard(
              icon: Icons.supervisor_account,
              title: 'Supervisor',
              onTap: () async {
                await service.saveRole('Supervisor');
                _goToProjects(context);
              },
            ),
            RoleCard(
              icon: Icons.admin_panel_settings,
              title: 'Manager',
              onTap: () async {
                await service.saveRole('Manager');
                _goToProjects(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToProjects(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => ProjectListScreen()),
      (_) => false,
    );
  }
}

class RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
