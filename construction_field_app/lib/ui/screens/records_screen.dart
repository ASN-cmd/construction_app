import 'package:flutter/material.dart';
import '../../data/local/app_database.dart';
import '../../services/records_service.dart';
import '../../repositories/records_repository.dart';

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
    return FutureBuilder<List<AttendanceRecordWithDistance>>(
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
          padding: const EdgeInsets.all(12),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final item = records[index];
            final record = item.record;
            final distance = item.distanceFromSite;

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  'Attendance ${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Time: ${record.timestamp}\n'
                  'Lat: ${record.latitude.toStringAsFixed(5)}\n'
                  'Lng: ${record.longitude.toStringAsFixed(5)}'
                  '${distance != null ? '\nDistance from site: ${distance.toStringAsFixed(0)} m' : ''}',
                ),
                trailing: distance != null
                    ? Icon(
                        distance <= 150
                            ? Icons.check_circle
                            : Icons.warning,
                        color:
                            distance <= 150 ? Colors.green : Colors.red,
                      )
                    : null,
              ),
            );
          },
        );
      },
    );
  }
}
