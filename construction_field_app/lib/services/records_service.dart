import 'package:geolocator/geolocator.dart';
import '../repositories/records_repository.dart';
import '../data/local/app_database.dart';

class AttendanceRecordWithDistance {
  final AttendanceTableData record;
  final double? distanceFromSite;

  AttendanceRecordWithDistance({
    required this.record,
    required this.distanceFromSite,
  });
}

class RecordsService {
  final RecordsRepository repo;

  RecordsService(this.repo);

  Future<List<AttendanceRecordWithDistance>> getRecordsWithDistance() async {
    final records = await repo.getAllAttendance();
    final site = await repo.getSite();

    if (site == null) {
      return records
          .map(
            (r) => AttendanceRecordWithDistance(
              record: r,
              distanceFromSite: null,
            ),
          )
          .toList();
    }

    return records.map((r) {
      final distance = Geolocator.distanceBetween(
        site.latitude,
        site.longitude,
        r.latitude,
        r.longitude,
      );

      return AttendanceRecordWithDistance(
        record: r,
        distanceFromSite: distance,
      );
    }).toList();
  }
}
