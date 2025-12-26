import 'package:geolocator/geolocator.dart';
import '../repositories/attendance_repository.dart';

class AttendanceService {
  final AttendanceRepository repo;

  AttendanceService(this.repo);

  /* -------- SET SITE -------- */
  Future<void> setSiteLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await repo.saveSite(
      position.latitude,
      position.longitude,
      150,
    );
  }

  /* -------- MARK ATTENDANCE -------- */
  Future<String> markAttendance() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return 'Location permission denied';
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final site = await repo.getSite();
    if (site == null) return 'Site not configured';

    final distance = Geolocator.distanceBetween(
      site.latitude,
      site.longitude,
      position.latitude,
      position.longitude,
    );

    if (distance > site.radius) {
      return 'Outside site boundary (${distance.toStringAsFixed(0)} m)';
    }

    await repo.saveAttendance(
      DateTime.now(),
      position.latitude,
      position.longitude,
    );

    return 'Attendance saved offline';
  }
}
