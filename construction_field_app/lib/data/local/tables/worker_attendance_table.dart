import 'package:drift/drift.dart';

class WorkerAttendance extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get workerId => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get status => text()();
  // present | half_day | absent

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
