import '../data/local/app_database.dart';

class RecordsRepository {
  final AppDatabase db;

  RecordsRepository(this.db);

  /// Fetch all attendance records
  Future<List<AttendanceTableData>> getAllAttendance() {
    return db.getAllAttendance();
  }

  /// Fetch site geofence (if exists)
  Future<SiteTableData?> getSite() {
    return db.getSiteGeofence();
  }
}
