import 'package:flutter/material.dart';
import '../../data/local/app_database.dart';
import '../../services/attendance_service.dart';
import '../../repositories/attendance_repository.dart';
import '../widgets/add_worker_sheet.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AppDatabase db;
  late AttendanceService service;

  @override
  void initState() {
    super.initState();
    db = AppDatabase();
    service = AttendanceService(AttendanceRepository(db));
  }

  Future<void> handleSetSiteLocation() async {
    try {
      await service.setSiteLocation();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Site location set successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> markWorker(int workerId, String status) async {
    try {
      await service.markWorkerAttendance(
        workerId: workerId,
        status: status,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Marked $status'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => AddWorkerSheet(service: service),
          );
          if (added == true) setState(() {});
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Worker'),
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

          FutureBuilder(
            future: db.getSiteGeofence(),
            builder: (context, snapshot) {
              final siteConfigured = snapshot.hasData && snapshot.data != null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    siteConfigured
                        ? 'Site configured'
                        : '⚠ Set site location to start attendance',
                    style: TextStyle(
                      color: siteConfigured ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Workers',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  FutureBuilder<List<Worker>>(
                    future: service.getWorkers(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No workers added');
                      }

                      final workers = snapshot.data!;

                      return Column(
                        children: workers.map((w) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(w.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '${w.designation} • ₹${w.dailyWage}/day'),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      _statusButton(
                                        'Present',
                                        Colors.green,
                                        siteConfigured
                                            ? () =>
                                                markWorker(w.id, 'present')
                                            : null,
                                      ),
                                      _statusButton(
                                        'Half',
                                        Colors.orange,
                                        siteConfigured
                                            ? () =>
                                                markWorker(w.id, 'half_day')
                                            : null,
                                      ),
                                      _statusButton(
                                        'Absent',
                                        Colors.red,
                                        siteConfigured
                                            ? () =>
                                                markWorker(w.id, 'absent')
                                            : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _statusButton(
      String label, Color color, VoidCallback? onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(label),
        ),
      ),
    );
  }
}
