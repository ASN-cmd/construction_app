import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart';
import 'dpr_screen.dart';
import 'records_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    AttendanceScreen(),
    DPRScreen(),
    RecordsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Dashboard'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Attendance'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'DPR'),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: 'Records'),
        ],
      ),

    );
  }
}
