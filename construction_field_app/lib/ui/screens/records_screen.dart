import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/local/app_database.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  late AppDatabase db;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Offline Records',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[800],
      ),

      body: FutureBuilder<List<AttendanceTableData>>(
        future: db.getAllAttendance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No attendance records found',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }

          final records = snapshot.data!;

          return FutureBuilder(
            future: db.getSiteGeofence(),
            builder: (context, siteSnapshot) {
              final site = siteSnapshot.data;

              return ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];

                  double? distance;
                  if (site != null) {
                    distance = Geolocator.distanceBetween(
                      site.latitude,
                      site.longitude,
                      record.latitude,
                      record.longitude,
                    );
                  }

                  return Card(
                    color: Colors.grey[100],
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: Text(
                        'Attendance ${index + 1}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Time: ${record.timestamp}\n'
                        'Lat: ${record.latitude.toStringAsFixed(5)}\n'
                        'Lng: ${record.longitude.toStringAsFixed(5)}'
                        '${distance != null ? '\nDistance from site: ${distance.toStringAsFixed(0)} m' : ''}',
                        style: const TextStyle(color: Colors.black87),
                      ),
                      trailing: site != null
                          ? Icon(
                              distance != null && distance <= site.radius
                                  ? Icons.check_circle
                                  : Icons.warning,
                              color: distance != null && distance <= site.radius
                                  ? Colors.green
                                  : Colors.red,
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
