import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/local/app_database.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AppDatabase db = AppDatabase();

  bool isLoading = false;
  String statusMessage = 'No attendance marked yet';

  /* ---------------- SET SITE LOCATION ---------------- */

  Future<void> setSiteLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      await db.saveSiteGeofence(
        position.latitude,
        position.longitude,
        150,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Site location set successfully'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error setting site location: $e')),
      );
    }
  }

  /* ---------------- MARK ATTENDANCE ---------------- */

  Future<void> markAttendance() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Processing attendance...';
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
          statusMessage = 'Location permission denied';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final site = await db.getSiteGeofence();

      if (site == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Site location not set'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => isLoading = false);
        return;
      }

      final distance = Geolocator.distanceBetween(
        site.latitude,
        site.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance > site.radius) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Outside site boundary (${distance.toStringAsFixed(0)} m)',
            ),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => isLoading = false);
        return;
      }

      await db.insertAttendance(
        DateTime.now(),
        position.latitude,
        position.longitude,
      );

      setState(() {
        isLoading = false;
        statusMessage = 'Attendance saved offline';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attendance marked successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error marking attendance: $e')),
      );
    }
  }

  /* ---------------- UI ---------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ White background

      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800], // ✅ Grey top bar
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: setSiteLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue, // ✅ Light blue button
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Set Site Location'),
          ),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: isLoading ? null : markAttendance,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue, // ✅ Light blue button
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
          const Divider(color: Colors.black26),
          const SizedBox(height: 12),

          const Text(
            'Configured Site (Geofence)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          FutureBuilder(
            future: db.getSiteGeofence(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text(
                  'Loading site info...',
                  style: TextStyle(color: Colors.black54),
                );
              }

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
