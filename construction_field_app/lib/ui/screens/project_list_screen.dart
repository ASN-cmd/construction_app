import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'project_home_screen.dart'; // Import the new navigation shell

class ProjectListScreen extends StatelessWidget {
  ProjectListScreen({super.key});

  final List<Project> projects = [
    Project(
      name: 'hone', // Renamed to match your Powerplay screenshot
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 6, 30),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade900,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create New',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () {
                // Navigate to the full Navigation Shell
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectHomeScreen(
                      projectName: project.name,
                    ),
                  ),
                );
              },
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.home_work_outlined, color: Colors.blue),
              ),
              title: Text(
                project.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_fmt(project.startDate)} - ${_fmt(project.endDate)}',
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ),
          );
        },
      ),
    );
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
}