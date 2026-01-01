import 'package:flutter/material.dart';
import '../../data/local/app_database.dart';
import '../../services/attendance_service.dart';
import '../../repositories/attendance_repository.dart';
import 'profile_screen.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AppDatabase db;
  late AttendanceService service;

  bool isLoading = false;
  String statusMessage = 'No attendance marked yet';

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    final repo = AttendanceRepository(db);
    service = AttendanceService(repo);

  }

  /* -------- UI ACTIONS ONLY -------- */

  Future<void> handleSetSiteLocation() async {
    try {
      await service.setSiteLocation();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Site location set successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> handleMarkAttendance() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Processing attendance...';
    });

    final result = await service.markAttendance();

    setState(() {
      isLoading = false;
      statusMessage = result;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
        backgroundColor:
            result.contains('saved') ? Colors.green : Colors.red,
      ),
    );
  }

  /* -------- UI -------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black, size: 18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 12),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: handleSetSiteLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Set Site Location'),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: isLoading ? null : handleMarkAttendance,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Mark Attendance'),
          ),

          const SizedBox(height: 20),

          Text(
            statusMessage,
            style: const TextStyle(color: Colors.black87),
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 12),

          const Text(
            'Configured Site (Geofence)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          FutureBuilder(
            future: db.getSiteGeofence(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Text(
                  'Site not configured yet',
                  style: TextStyle(color: Colors.red),
                );
              }

              final site = snapshot.data!;
              return Text(
                'Latitude: ${site.latitude.toStringAsFixed(5)}\n'
                'Longitude: ${site.longitude.toStringAsFixed(5)}\n'
                'Radius: ${site.radius.toInt()} meters',
                style: const TextStyle(color: Colors.black87),
              );
            },
          ),
        ],
      ),
    );
  }
}
