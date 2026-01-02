import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'project_scaffold.dart';

class ProjectListScreen extends StatelessWidget {
  ProjectListScreen({super.key});

  final List<Project> projects = [
    Project(
      name: 'Home',
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 6, 30),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          TextButton.icon(
            onPressed: () {
              // future: open create project screen
            },
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProjectScaffold(
                      projectName: project.name,
                    ),
                  ),
                );
              },
              leading: const Icon(Icons.home_work_outlined),
              title: Text(
                project.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${_fmt(project.startDate)} - ${_fmt(project.endDate)}',
              ),
              trailing: Chip(
                label: Text(project.isActive ? 'Active' : 'Inactive'),
                backgroundColor:
                    project.isActive ? Colors.green.shade100 : Colors.grey[300],
              ),
            ),
          );
        },
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';
}