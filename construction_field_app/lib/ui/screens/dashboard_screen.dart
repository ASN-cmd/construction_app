import 'package:flutter/material.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String projectName;

  const DashboardScreen({
    super.key,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 18,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: const Center(
        child: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
