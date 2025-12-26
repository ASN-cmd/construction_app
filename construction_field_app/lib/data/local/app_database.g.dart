// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AttendanceTableTable extends AttendanceTable
    with TableInfo<$AttendanceTableTable, AttendanceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timestamp,
    latitude,
    longitude,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $AttendanceTableTable createAlias(String alias) {
    return $AttendanceTableTable(attachedDatabase, alias);
  }
}

class AttendanceTableData extends DataClass
    implements Insertable<AttendanceTableData> {
  final int id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final bool synced;
  const AttendanceTableData({
    required this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  AttendanceTableCompanion toCompanion(bool nullToAbsent) {
    return AttendanceTableCompanion(
      id: Value(id),
      timestamp: Value(timestamp),
      latitude: Value(latitude),
      longitude: Value(longitude),
      synced: Value(synced),
    );
  }

  factory AttendanceTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceTableData(
      id: serializer.fromJson<int>(json['id']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  AttendanceTableData copyWith({
    int? id,
    DateTime? timestamp,
    double? latitude,
    double? longitude,
    bool? synced,
  }) => AttendanceTableData(
    id: id ?? this.id,
    timestamp: timestamp ?? this.timestamp,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    synced: synced ?? this.synced,
  );
  AttendanceTableData copyWithCompanion(AttendanceTableCompanion data) {
    return AttendanceTableData(
      id: data.id.present ? data.id.value : this.id,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceTableData(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, timestamp, latitude, longitude, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceTableData &&
          other.id == this.id &&
          other.timestamp == this.timestamp &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.synced == this.synced);
}

class AttendanceTableCompanion extends UpdateCompanion<AttendanceTableData> {
  final Value<int> id;
  final Value<DateTime> timestamp;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<bool> synced;
  const AttendanceTableCompanion({
    this.id = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.synced = const Value.absent(),
  });
  AttendanceTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    this.synced = const Value.absent(),
  }) : timestamp = Value(timestamp),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<AttendanceTableData> custom({
    Expression<int>? id,
    Expression<DateTime>? timestamp,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? synced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timestamp != null) 'timestamp': timestamp,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (synced != null) 'synced': synced,
    });
  }

  AttendanceTableCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? timestamp,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<bool>? synced,
  }) {
    return AttendanceTableCompanion(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      synced: synced ?? this.synced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceTableCompanion(')
          ..write('id: $id, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }
}

class $SiteTableTable extends SiteTable
    with TableInfo<$SiteTableTable, SiteTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SiteTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _radiusMeta = const VerificationMeta('radius');
  @override
  late final GeneratedColumn<double> radius = GeneratedColumn<double>(
    'radius',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(150),
  );
  @override
  List<GeneratedColumn> get $columns => [id, latitude, longitude, radius];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'site_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SiteTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('radius')) {
      context.handle(
        _radiusMeta,
        radius.isAcceptableOrUnknown(data['radius']!, _radiusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SiteTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SiteTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      radius: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}radius'],
      )!,
    );
  }

  @override
  $SiteTableTable createAlias(String alias) {
    return $SiteTableTable(attachedDatabase, alias);
  }
}

class SiteTableData extends DataClass implements Insertable<SiteTableData> {
  final int id;
  final double latitude;
  final double longitude;
  final double radius;
  const SiteTableData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['radius'] = Variable<double>(radius);
    return map;
  }

  SiteTableCompanion toCompanion(bool nullToAbsent) {
    return SiteTableCompanion(
      id: Value(id),
      latitude: Value(latitude),
      longitude: Value(longitude),
      radius: Value(radius),
    );
  }

  factory SiteTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SiteTableData(
      id: serializer.fromJson<int>(json['id']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      radius: serializer.fromJson<double>(json['radius']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'radius': serializer.toJson<double>(radius),
    };
  }

  SiteTableData copyWith({
    int? id,
    double? latitude,
    double? longitude,
    double? radius,
  }) => SiteTableData(
    id: id ?? this.id,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    radius: radius ?? this.radius,
  );
  SiteTableData copyWithCompanion(SiteTableCompanion data) {
    return SiteTableData(
      id: data.id.present ? data.id.value : this.id,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      radius: data.radius.present ? data.radius.value : this.radius,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SiteTableData(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('radius: $radius')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, latitude, longitude, radius);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SiteTableData &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.radius == this.radius);
}

class SiteTableCompanion extends UpdateCompanion<SiteTableData> {
  final Value<int> id;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> radius;
  const SiteTableCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.radius = const Value.absent(),
  });
  SiteTableCompanion.insert({
    this.id = const Value.absent(),
    required double latitude,
    required double longitude,
    this.radius = const Value.absent(),
  }) : latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<SiteTableData> custom({
    Expression<int>? id,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? radius,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (radius != null) 'radius': radius,
    });
  }

  SiteTableCompanion copyWith({
    Value<int>? id,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? radius,
  }) {
    return SiteTableCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (radius.present) {
      map['radius'] = Variable<double>(radius.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SiteTableCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('radius: $radius')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AttendanceTableTable attendanceTable = $AttendanceTableTable(
    this,
  );
  late final $SiteTableTable siteTable = $SiteTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    attendanceTable,
    siteTable,
  ];
}

typedef $$AttendanceTableTableCreateCompanionBuilder =
    AttendanceTableCompanion Function({
      Value<int> id,
      required DateTime timestamp,
      required double latitude,
      required double longitude,
      Value<bool> synced,
    });
typedef $$AttendanceTableTableUpdateCompanionBuilder =
    AttendanceTableCompanion Function({
      Value<int> id,
      Value<DateTime> timestamp,
      Value<double> latitude,
      Value<double> longitude,
      Value<bool> synced,
    });

class $$AttendanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttendanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttendanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceTableTable> {
  $$AttendanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$AttendanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceTableTable,
          AttendanceTableData,
          $$AttendanceTableTableFilterComposer,
          $$AttendanceTableTableOrderingComposer,
          $$AttendanceTableTableAnnotationComposer,
          $$AttendanceTableTableCreateCompanionBuilder,
          $$AttendanceTableTableUpdateCompanionBuilder,
          (
            AttendanceTableData,
            BaseReferences<
              _$AppDatabase,
              $AttendanceTableTable,
              AttendanceTableData
            >,
          ),
          AttendanceTableData,
          PrefetchHooks Function()
        > {
  $$AttendanceTableTableTableManager(
    _$AppDatabase db,
    $AttendanceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<bool> synced = const Value.absent(),
              }) => AttendanceTableCompanion(
                id: id,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                synced: synced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime timestamp,
                required double latitude,
                required double longitude,
                Value<bool> synced = const Value.absent(),
              }) => AttendanceTableCompanion.insert(
                id: id,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                synced: synced,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttendanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceTableTable,
      AttendanceTableData,
      $$AttendanceTableTableFilterComposer,
      $$AttendanceTableTableOrderingComposer,
      $$AttendanceTableTableAnnotationComposer,
      $$AttendanceTableTableCreateCompanionBuilder,
      $$AttendanceTableTableUpdateCompanionBuilder,
      (
        AttendanceTableData,
        BaseReferences<
          _$AppDatabase,
          $AttendanceTableTable,
          AttendanceTableData
        >,
      ),
      AttendanceTableData,
      PrefetchHooks Function()
    >;
typedef $$SiteTableTableCreateCompanionBuilder =
    SiteTableCompanion Function({
      Value<int> id,
      required double latitude,
      required double longitude,
      Value<double> radius,
    });
typedef $$SiteTableTableUpdateCompanionBuilder =
    SiteTableCompanion Function({
      Value<int> id,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> radius,
    });

class $$SiteTableTableFilterComposer
    extends Composer<_$AppDatabase, $SiteTableTable> {
  $$SiteTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get radius => $composableBuilder(
    column: $table.radius,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SiteTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SiteTableTable> {
  $$SiteTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get radius => $composableBuilder(
    column: $table.radius,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SiteTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SiteTableTable> {
  $$SiteTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get radius =>
      $composableBuilder(column: $table.radius, builder: (column) => column);
}

class $$SiteTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SiteTableTable,
          SiteTableData,
          $$SiteTableTableFilterComposer,
          $$SiteTableTableOrderingComposer,
          $$SiteTableTableAnnotationComposer,
          $$SiteTableTableCreateCompanionBuilder,
          $$SiteTableTableUpdateCompanionBuilder,
          (
            SiteTableData,
            BaseReferences<_$AppDatabase, $SiteTableTable, SiteTableData>,
          ),
          SiteTableData,
          PrefetchHooks Function()
        > {
  $$SiteTableTableTableManager(_$AppDatabase db, $SiteTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SiteTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SiteTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SiteTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> radius = const Value.absent(),
              }) => SiteTableCompanion(
                id: id,
                latitude: latitude,
                longitude: longitude,
                radius: radius,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double latitude,
                required double longitude,
                Value<double> radius = const Value.absent(),
              }) => SiteTableCompanion.insert(
                id: id,
                latitude: latitude,
                longitude: longitude,
                radius: radius,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SiteTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SiteTableTable,
      SiteTableData,
      $$SiteTableTableFilterComposer,
      $$SiteTableTableOrderingComposer,
      $$SiteTableTableAnnotationComposer,
      $$SiteTableTableCreateCompanionBuilder,
      $$SiteTableTableUpdateCompanionBuilder,
      (
        SiteTableData,
        BaseReferences<_$AppDatabase, $SiteTableTable, SiteTableData>,
      ),
      SiteTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AttendanceTableTableTableManager get attendanceTable =>
      $$AttendanceTableTableTableManager(_db, _db.attendanceTable);
  $$SiteTableTableTableManager get siteTable =>
      $$SiteTableTableTableManager(_db, _db.siteTable);
}
