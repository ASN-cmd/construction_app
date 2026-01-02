import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// TABLES
import 'site_table.dart';
import 'attendance_table.dart';
import 'tables/workers_table.dart';
import 'tables/worker_attendance_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SiteTable,
    AttendanceTable,
    Workers,
    WorkerAttendance,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /* ---------------- SITE GEOFENCE ---------------- */

  Future<void> saveSiteGeofence(
    double lat,
    double lng,
    double radius,
  ) async {
    // Only one site for prototype
    await delete(siteTable).go();

    await into(siteTable).insert(
      SiteTableCompanion.insert(
        latitude: lat,
        longitude: lng,
      ),
    );
  }

  Future<SiteTableData?> getSiteGeofence() {
    return (select(siteTable)..limit(1)).getSingleOrNull();
  }

  /* ---------------- BASIC ATTENDANCE (GPS LOG) ---------------- */

  Future<void> insertAttendance(
    DateTime time,
    double lat,
    double lng,
  ) async {
    await into(attendanceTable).insert(
      AttendanceTableCompanion.insert(
        timestamp: time,
        latitude: lat,
        longitude: lng,
      ),
    );
  }

  Future<List<AttendanceTableData>> getAllAttendance() {
    return select(attendanceTable).get();
  }

  /* ---------------- WORKERS ---------------- */

  Future<int> insertWorker({
    required String name,
    required String designation,
    required double dailyWage,
  }) {
    return into(workers).insert(
      WorkersCompanion.insert(
        name: name,
        designation: designation,
        dailyWage: dailyWage,
      ),
    );
  }

  Future<List<Worker>> getAllWorkers() {
    return select(workers).get();
  }

  /* ---------------- WORKER ATTENDANCE ---------------- */

  Future<void> insertWorkerAttendance({
    required int workerId,
    required DateTime date,
    required String status,
    required double latitude,
    required double longitude,
  }) {
    return into(workerAttendance).insert(
      WorkerAttendanceCompanion.insert(
        workerId: workerId,
        date: date,
        status: status,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  Future<List<WorkerAttendanceData>> getWorkerAttendanceForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));

    return (select(
      workerAttendance,
    )..where((tbl) => tbl.date.isBetweenValues(start, end))).get();
  }
}

/* ---------------- DB CONNECTION ---------------- */

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'construction_app.db'));
    return NativeDatabase(file);
  });
}
