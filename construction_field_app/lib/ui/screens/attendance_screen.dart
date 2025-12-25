import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Attendance Module',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
