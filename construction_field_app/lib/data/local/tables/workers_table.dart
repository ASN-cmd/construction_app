import 'package:drift/drift.dart';

class Workers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get designation => text()();
  RealColumn get dailyWage => real()();
}
