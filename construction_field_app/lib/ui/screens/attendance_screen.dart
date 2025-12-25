import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String statusMessage = 'No attendance marked yet';
  Position? currentPosition;
  bool isLoading = false;

  Future<void> markAttendance() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Fetching location...';
    });

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      setState(() {
        isLoading = false;
        statusMessage = 'Location permission denied';
      });
      return;
    }

    // Get location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = position;
      isLoading = false;
      statusMessage = 'Attendance saved offline';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance saved offline'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mark Attendance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: isLoading ? null : markAttendance,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Mark Attendance'),
            ),

            const SizedBox(height: 24),

            Text(
              statusMessage,
              style: const TextStyle(color: Colors.white70),
            ),

            const SizedBox(height: 16),

            if (currentPosition != null)
              Text(
                'Latitude: ${currentPosition!.latitude}\n'
                'Longitude: ${currentPosition!.longitude}\n'
                'Time: ${DateTime.now()}',
                style: const TextStyle(color: Colors.white70),
              ),
          ],
        ),
      ),
    );
  }
}
