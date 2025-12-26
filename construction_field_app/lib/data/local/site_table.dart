import 'package:drift/drift.dart';

class SiteTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get latitude => real()();

  RealColumn get longitude => real()();

  RealColumn get radius =>
      real().withDefault(const Constant(150))(); // meters
}
