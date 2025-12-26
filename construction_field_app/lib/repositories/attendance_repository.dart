import '../data/local/app_database.dart';

class AttendanceRepository {
  final AppDatabase db;

  AttendanceRepository(this.db);

  // -------- SITE --------
  Future<void> saveSite(double lat, double lng, double radius) {
    return db.saveSiteGeofence(lat, lng, radius);
  }

  Future<SiteTableData?> getSite() {
    return db.getSiteGeofence();
  }

  // -------- ATTENDANCE --------
  Future<void> saveAttendance(
      DateTime time, double lat, double lng) {
    return db.insertAttendance(time, lat, lng);
  }

  Future<List<AttendanceTableData>> getAllAttendance() {
    return db.getAllAttendance();
  }
}
