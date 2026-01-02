import '../data/local/app_database.dart';
import '../models/worker_attendance_record.dart';
import 'package:drift/drift.dart';

class AttendanceRepository {
  final AppDatabase db;

  AttendanceRepository(this.db);

  Future<List<WorkerAttendanceRecord>> getWorkerAttendanceRecords() async {
    final query = db.select(db.workerAttendance).join([
      innerJoin(
        db.workers,
        db.workers.id.equalsExp(db.workerAttendance.workerId),
      ),
    ]);

    final rows = await query.get();

    return rows.map((row) {
      final attendance = row.readTable(db.workerAttendance);
      final worker = row.readTable(db.workers);

      return WorkerAttendanceRecord(
        workerName: worker.name,
        designation: worker.designation,
        status: attendance.status,
        date: attendance.date,
      );
    }).toList();
  }

  /* -------- SITE -------- */

  Future<void> saveSite(double lat, double lng, double radius) {
    return db.saveSiteGeofence(lat, lng, radius);
  }

  Future<SiteTableData?> getSite() {
    return db.getSiteGeofence();
  }

  /* -------- BASIC ATTENDANCE (GPS LOG) -------- */

  Future<void> saveAttendance(
    DateTime time,
    double lat,
    double lng,
  ) {
    return db.insertAttendance(time, lat, lng);
  }

  /* -------- WORKERS -------- */

  Future<int> insertWorker({
    required String name,
    required String designation,
    required double dailyWage,
  }) {
    return db.insertWorker(
      name: name,
      designation: designation,
      dailyWage: dailyWage,
    );
  }

  Future<List<Worker>> getAllWorkers() {
    return db.getAllWorkers();
  }

  /* -------- WORKER ATTENDANCE -------- */

  Future<void> insertWorkerAttendance({
    required int workerId,
    required DateTime date,
    required String status,
    required double latitude,
    required double longitude,
  }) {
    return db.insertWorkerAttendance(
      workerId: workerId,
      date: date,
      status: status,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Future<List<WorkerAttendanceData>> getWorkerAttendanceForDate(
      DateTime date) {
    return db.getWorkerAttendanceForDate(date);
  }
}
