import 'package:geolocator/geolocator.dart';
import '../repositories/attendance_repository.dart';
import '../data/local/app_database.dart';

class AttendanceService {
  final AttendanceRepository repo;

  AttendanceService(this.repo);

  /* ---------------- WORKERS ---------------- */

  Future<void> addWorker({
    required String name,
    required String designation,
    required double dailyWage,
  }) {
    return repo.insertWorker(
      name: name,
      designation: designation,
      dailyWage: dailyWage,
    );
  }

  Future<List<Worker>> getWorkers() {
    return repo.getAllWorkers();
  }

  /* ---------------- SITE ---------------- */

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

  /* ---------------- WORKER ATTENDANCE ---------------- */

  Future<void> markWorkerAttendance({
    required int workerId,
    required String status, // present | half_day | absent
  }) async {
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

    final site = await repo.getSite();
    if (site == null) {
      throw Exception('Set site location first');
    }

    final distance = Geolocator.distanceBetween(
      site.latitude,
      site.longitude,
      position.latitude,
      position.longitude,
    );

    if (distance > site.radius) {
      throw Exception(
          'Outside site boundary (${distance.toStringAsFixed(0)} m)');
    }

    await repo.insertWorkerAttendance(
      workerId: workerId,
      date: DateTime.now(),
      status: status,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
