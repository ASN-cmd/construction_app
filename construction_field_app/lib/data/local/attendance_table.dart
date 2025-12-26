import 'package:drift/drift.dart';

class AttendanceTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get timestamp => dateTime()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  BoolColumn get synced =>
      boolean().withDefault(const Constant(false))();
}
