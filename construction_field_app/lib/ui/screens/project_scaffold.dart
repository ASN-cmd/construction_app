import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart';
import 'records_screen.dart';
import 'project_list_screen.dart';
import 'profile_screen.dart';

class ProjectScaffold extends StatefulWidget {
  final String projectName;

  const ProjectScaffold({
    super.key,
    required this.projectName,
  });

  @override
  State<ProjectScaffold> createState() => _ProjectScaffoldState();
}

class _ProjectScaffoldState extends State<ProjectScaffold> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(projectName: widget.projectName),
      const AttendanceScreen(),
      const RecordsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProjectListScreen()),
            );
          },
        ),
        title: Text(
          widget.projectName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(),
                ),
              );
            },
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_reg),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Records',
          ),
        ],
      ),
    );
  }
}
