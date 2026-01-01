import 'package:flutter/material.dart';

import '../../data/local/app_database.dart';
import '../../services/records_service.dart';
import '../../repositories/records_repository.dart';
import 'profile_screen.dart';



class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  late AppDatabase db;
  late RecordsService service;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    final repo = RecordsRepository(db);
    service = RecordsService(repo);
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

      body: FutureBuilder<List<AttendanceRecordWithDistance>>(
        future: service.getRecordsWithDistance(),
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

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final item = records[index];
              final record = item.record;
              final distance = item.distanceFromSite;

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
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Time: ${record.timestamp}\n'
                    'Lat: ${record.latitude.toStringAsFixed(5)}\n'
                    'Lng: ${record.longitude.toStringAsFixed(5)}'
                    '${distance != null ? '\nDistance from site: ${distance.toStringAsFixed(0)} m' : ''}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  trailing: distance != null
                      ? Icon(
                          distance <= 150
                              ? Icons.check_circle
                              : Icons.warning,
                          color: distance <= 150
                              ? Colors.green
                              : Colors.red,
                        )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
