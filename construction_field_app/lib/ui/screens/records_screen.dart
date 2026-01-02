import 'package:flutter/material.dart';
import '../../data/local/app_database.dart';
import '../../repositories/attendance_repository.dart';
import '../../models/worker_attendance_record.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  late AppDatabase db;
  late AttendanceRepository repo;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    repo = AttendanceRepository(db);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkerAttendanceRecord>>(
      future: repo.getWorkerAttendanceRecords(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final records = snapshot.data!;
        if (records.isEmpty) {
          return const Center(
            child: Text('No attendance records found'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final r = records[index];

            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ListTile(
                title: Text(
                  r.workerName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${r.designation}\n'
                  '${r.status.toUpperCase()} • '
                  '${r.date.toLocal().toString().split(' ')[0]}',
                ),
                trailing: Icon(
                  r.status == 'present'
                      ? Icons.check_circle
                      : r.status == 'half_day'
                          ? Icons.remove_circle
                          : Icons.cancel,
                  color: r.status == 'present'
                      ? Colors.green
                      : r.status == 'half_day'
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
