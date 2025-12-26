import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'site_table.dart';

import 'attendance_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [AttendanceTable, SiteTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> saveSiteGeofence(
      double lat, double lng, double radius) async {
    await delete(siteTable).go(); // Only one site for prototype

    await into(siteTable).insert(
      SiteTableCompanion.insert(
        latitude: lat,
        longitude: lng,
      ),
    );
} 

  Future<SiteTableData?> getSiteGeofence() async {
    return (select(siteTable)..limit(1)).getSingleOrNull();
  }


  Future<void> insertAttendance(
      DateTime time, double lat, double lng) async {
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'construction_app.db'));
    return NativeDatabase(file);
  });
}
