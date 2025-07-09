// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SavedConnectionTableTable extends SavedConnectionTable
    with TableInfo<$SavedConnectionTableTable, SavedConnection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedConnectionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<Connection, String> connection =
      GeneratedColumn<String>('connection', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<Connection>(
              $SavedConnectionTableTable.$converterconnection);
  @override
  List<GeneratedColumn> get $columns => [id, connection];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_connection_table';
  @override
  VerificationContext validateIntegrity(Insertable<SavedConnection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedConnection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedConnection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      connection: $SavedConnectionTableTable.$converterconnection.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}connection'])!),
    );
  }

  @override
  $SavedConnectionTableTable createAlias(String alias) {
    return $SavedConnectionTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Connection, String, Map<String, dynamic>>
      $converterconnection = const ConnectionConverter();
}

class SavedConnection extends DataClass implements Insertable<SavedConnection> {
  final int id;
  final Connection connection;
  const SavedConnection({required this.id, required this.connection});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['connection'] = Variable<String>(
          $SavedConnectionTableTable.$converterconnection.toSql(connection));
    }
    return map;
  }

  SavedConnectionTableCompanion toCompanion(bool nullToAbsent) {
    return SavedConnectionTableCompanion(
      id: Value(id),
      connection: Value(connection),
    );
  }

  factory SavedConnection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedConnection(
      id: serializer.fromJson<int>(json['id']),
      connection: $SavedConnectionTableTable.$converterconnection.fromJson(
          serializer.fromJson<Map<String, dynamic>>(json['connection'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'connection': serializer.toJson<Map<String, dynamic>>(
          $SavedConnectionTableTable.$converterconnection.toJson(connection)),
    };
  }

  SavedConnection copyWith({int? id, Connection? connection}) =>
      SavedConnection(
        id: id ?? this.id,
        connection: connection ?? this.connection,
      );
  SavedConnection copyWithCompanion(SavedConnectionTableCompanion data) {
    return SavedConnection(
      id: data.id.present ? data.id.value : this.id,
      connection:
          data.connection.present ? data.connection.value : this.connection,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedConnection(')
          ..write('id: $id, ')
          ..write('connection: $connection')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, connection);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedConnection &&
          other.id == this.id &&
          other.connection == this.connection);
}

class SavedConnectionTableCompanion extends UpdateCompanion<SavedConnection> {
  final Value<int> id;
  final Value<Connection> connection;
  const SavedConnectionTableCompanion({
    this.id = const Value.absent(),
    this.connection = const Value.absent(),
  });
  SavedConnectionTableCompanion.insert({
    this.id = const Value.absent(),
    required Connection connection,
  }) : connection = Value(connection);
  static Insertable<SavedConnection> custom({
    Expression<int>? id,
    Expression<String>? connection,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (connection != null) 'connection': connection,
    });
  }

  SavedConnectionTableCompanion copyWith(
      {Value<int>? id, Value<Connection>? connection}) {
    return SavedConnectionTableCompanion(
      id: id ?? this.id,
      connection: connection ?? this.connection,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (connection.present) {
      map['connection'] = Variable<String>($SavedConnectionTableTable
          .$converterconnection
          .toSql(connection.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedConnectionTableCompanion(')
          ..write('id: $id, ')
          ..write('connection: $connection')
          ..write(')'))
        .toString();
  }
}

class $LocationHistoryTableTable extends LocationHistoryTable
    with TableInfo<$LocationHistoryTableTable, LocationHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<Location, String> location =
      GeneratedColumn<String>('location', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: true,
              defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'))
          .withConverter<Location>(
              $LocationHistoryTableTable.$converterlocation);
  static const VerificationMeta _lastSearchedMeta =
      const VerificationMeta('lastSearched');
  @override
  late final GeneratedColumn<DateTime> lastSearched = GeneratedColumn<DateTime>(
      'last_searched', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _searchCountMeta =
      const VerificationMeta('searchCount');
  @override
  late final GeneratedColumn<int> searchCount = GeneratedColumn<int>(
      'search_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, location, lastSearched, searchCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_history_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocationHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_searched')) {
      context.handle(
          _lastSearchedMeta,
          lastSearched.isAcceptableOrUnknown(
              data['last_searched']!, _lastSearchedMeta));
    } else if (isInserting) {
      context.missing(_lastSearchedMeta);
    }
    if (data.containsKey('search_count')) {
      context.handle(
          _searchCountMeta,
          searchCount.isAcceptableOrUnknown(
              data['search_count']!, _searchCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      location: $LocationHistoryTableTable.$converterlocation.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}location'])!),
      lastSearched: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_searched'])!,
      searchCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}search_count'])!,
    );
  }

  @override
  $LocationHistoryTableTable createAlias(String alias) {
    return $LocationHistoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Location, String, Map<String, dynamic>>
      $converterlocation = const LocationConverter();
}

class LocationHistoryData extends DataClass
    implements Insertable<LocationHistoryData> {
  final int id;
  final Location location;
  final DateTime lastSearched;
  final int searchCount;
  const LocationHistoryData(
      {required this.id,
      required this.location,
      required this.lastSearched,
      required this.searchCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['location'] = Variable<String>(
          $LocationHistoryTableTable.$converterlocation.toSql(location));
    }
    map['last_searched'] = Variable<DateTime>(lastSearched);
    map['search_count'] = Variable<int>(searchCount);
    return map;
  }

  LocationHistoryTableCompanion toCompanion(bool nullToAbsent) {
    return LocationHistoryTableCompanion(
      id: Value(id),
      location: Value(location),
      lastSearched: Value(lastSearched),
      searchCount: Value(searchCount),
    );
  }

  factory LocationHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationHistoryData(
      id: serializer.fromJson<int>(json['id']),
      location: $LocationHistoryTableTable.$converterlocation.fromJson(
          serializer.fromJson<Map<String, dynamic>>(json['location'])),
      lastSearched: serializer.fromJson<DateTime>(json['lastSearched']),
      searchCount: serializer.fromJson<int>(json['searchCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'location': serializer.toJson<Map<String, dynamic>>(
          $LocationHistoryTableTable.$converterlocation.toJson(location)),
      'lastSearched': serializer.toJson<DateTime>(lastSearched),
      'searchCount': serializer.toJson<int>(searchCount),
    };
  }

  LocationHistoryData copyWith(
          {int? id,
          Location? location,
          DateTime? lastSearched,
          int? searchCount}) =>
      LocationHistoryData(
        id: id ?? this.id,
        location: location ?? this.location,
        lastSearched: lastSearched ?? this.lastSearched,
        searchCount: searchCount ?? this.searchCount,
      );
  LocationHistoryData copyWithCompanion(LocationHistoryTableCompanion data) {
    return LocationHistoryData(
      id: data.id.present ? data.id.value : this.id,
      location: data.location.present ? data.location.value : this.location,
      lastSearched: data.lastSearched.present
          ? data.lastSearched.value
          : this.lastSearched,
      searchCount:
          data.searchCount.present ? data.searchCount.value : this.searchCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationHistoryData(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('lastSearched: $lastSearched, ')
          ..write('searchCount: $searchCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, location, lastSearched, searchCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationHistoryData &&
          other.id == this.id &&
          other.location == this.location &&
          other.lastSearched == this.lastSearched &&
          other.searchCount == this.searchCount);
}

class LocationHistoryTableCompanion
    extends UpdateCompanion<LocationHistoryData> {
  final Value<int> id;
  final Value<Location> location;
  final Value<DateTime> lastSearched;
  final Value<int> searchCount;
  const LocationHistoryTableCompanion({
    this.id = const Value.absent(),
    this.location = const Value.absent(),
    this.lastSearched = const Value.absent(),
    this.searchCount = const Value.absent(),
  });
  LocationHistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required Location location,
    required DateTime lastSearched,
    this.searchCount = const Value.absent(),
  })  : location = Value(location),
        lastSearched = Value(lastSearched);
  static Insertable<LocationHistoryData> custom({
    Expression<int>? id,
    Expression<String>? location,
    Expression<DateTime>? lastSearched,
    Expression<int>? searchCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (location != null) 'location': location,
      if (lastSearched != null) 'last_searched': lastSearched,
      if (searchCount != null) 'search_count': searchCount,
    });
  }

  LocationHistoryTableCompanion copyWith(
      {Value<int>? id,
      Value<Location>? location,
      Value<DateTime>? lastSearched,
      Value<int>? searchCount}) {
    return LocationHistoryTableCompanion(
      id: id ?? this.id,
      location: location ?? this.location,
      lastSearched: lastSearched ?? this.lastSearched,
      searchCount: searchCount ?? this.searchCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(
          $LocationHistoryTableTable.$converterlocation.toSql(location.value));
    }
    if (lastSearched.present) {
      map['last_searched'] = Variable<DateTime>(lastSearched.value);
    }
    if (searchCount.present) {
      map['search_count'] = Variable<int>(searchCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('location: $location, ')
          ..write('lastSearched: $lastSearched, ')
          ..write('searchCount: $searchCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedConnectionTableTable savedConnectionTable =
      $SavedConnectionTableTable(this);
  late final $LocationHistoryTableTable locationHistoryTable =
      $LocationHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedConnectionTable, locationHistoryTable];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$SavedConnectionTableTableCreateCompanionBuilder
    = SavedConnectionTableCompanion Function({
  Value<int> id,
  required Connection connection,
});
typedef $$SavedConnectionTableTableUpdateCompanionBuilder
    = SavedConnectionTableCompanion Function({
  Value<int> id,
  Value<Connection> connection,
});

class $$SavedConnectionTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedConnectionTableTable> {
  $$SavedConnectionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Connection, Connection, String>
      get connection => $composableBuilder(
          column: $table.connection,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$SavedConnectionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedConnectionTableTable> {
  $$SavedConnectionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get connection => $composableBuilder(
      column: $table.connection, builder: (column) => ColumnOrderings(column));
}

class $$SavedConnectionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedConnectionTableTable> {
  $$SavedConnectionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Connection, String> get connection =>
      $composableBuilder(
          column: $table.connection, builder: (column) => column);
}

class $$SavedConnectionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedConnectionTableTable,
    SavedConnection,
    $$SavedConnectionTableTableFilterComposer,
    $$SavedConnectionTableTableOrderingComposer,
    $$SavedConnectionTableTableAnnotationComposer,
    $$SavedConnectionTableTableCreateCompanionBuilder,
    $$SavedConnectionTableTableUpdateCompanionBuilder,
    (
      SavedConnection,
      BaseReferences<_$AppDatabase, $SavedConnectionTableTable, SavedConnection>
    ),
    SavedConnection,
    PrefetchHooks Function()> {
  $$SavedConnectionTableTableTableManager(
      _$AppDatabase db, $SavedConnectionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedConnectionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedConnectionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedConnectionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Connection> connection = const Value.absent(),
          }) =>
              SavedConnectionTableCompanion(
            id: id,
            connection: connection,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required Connection connection,
          }) =>
              SavedConnectionTableCompanion.insert(
            id: id,
            connection: connection,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavedConnectionTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SavedConnectionTableTable,
        SavedConnection,
        $$SavedConnectionTableTableFilterComposer,
        $$SavedConnectionTableTableOrderingComposer,
        $$SavedConnectionTableTableAnnotationComposer,
        $$SavedConnectionTableTableCreateCompanionBuilder,
        $$SavedConnectionTableTableUpdateCompanionBuilder,
        (
          SavedConnection,
          BaseReferences<_$AppDatabase, $SavedConnectionTableTable,
              SavedConnection>
        ),
        SavedConnection,
        PrefetchHooks Function()>;
typedef $$LocationHistoryTableTableCreateCompanionBuilder
    = LocationHistoryTableCompanion Function({
  Value<int> id,
  required Location location,
  required DateTime lastSearched,
  Value<int> searchCount,
});
typedef $$LocationHistoryTableTableUpdateCompanionBuilder
    = LocationHistoryTableCompanion Function({
  Value<int> id,
  Value<Location> location,
  Value<DateTime> lastSearched,
  Value<int> searchCount,
});

class $$LocationHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $LocationHistoryTableTable> {
  $$LocationHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<Location, Location, String> get location =>
      $composableBuilder(
          column: $table.location,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get lastSearched => $composableBuilder(
      column: $table.lastSearched, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get searchCount => $composableBuilder(
      column: $table.searchCount, builder: (column) => ColumnFilters(column));
}

class $$LocationHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationHistoryTableTable> {
  $$LocationHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSearched => $composableBuilder(
      column: $table.lastSearched,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get searchCount => $composableBuilder(
      column: $table.searchCount, builder: (column) => ColumnOrderings(column));
}

class $$LocationHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationHistoryTableTable> {
  $$LocationHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Location, String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSearched => $composableBuilder(
      column: $table.lastSearched, builder: (column) => column);

  GeneratedColumn<int> get searchCount => $composableBuilder(
      column: $table.searchCount, builder: (column) => column);
}

class $$LocationHistoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocationHistoryTableTable,
    LocationHistoryData,
    $$LocationHistoryTableTableFilterComposer,
    $$LocationHistoryTableTableOrderingComposer,
    $$LocationHistoryTableTableAnnotationComposer,
    $$LocationHistoryTableTableCreateCompanionBuilder,
    $$LocationHistoryTableTableUpdateCompanionBuilder,
    (
      LocationHistoryData,
      BaseReferences<_$AppDatabase, $LocationHistoryTableTable,
          LocationHistoryData>
    ),
    LocationHistoryData,
    PrefetchHooks Function()> {
  $$LocationHistoryTableTableTableManager(
      _$AppDatabase db, $LocationHistoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationHistoryTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationHistoryTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<Location> location = const Value.absent(),
            Value<DateTime> lastSearched = const Value.absent(),
            Value<int> searchCount = const Value.absent(),
          }) =>
              LocationHistoryTableCompanion(
            id: id,
            location: location,
            lastSearched: lastSearched,
            searchCount: searchCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required Location location,
            required DateTime lastSearched,
            Value<int> searchCount = const Value.absent(),
          }) =>
              LocationHistoryTableCompanion.insert(
            id: id,
            location: location,
            lastSearched: lastSearched,
            searchCount: searchCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocationHistoryTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $LocationHistoryTableTable,
        LocationHistoryData,
        $$LocationHistoryTableTableFilterComposer,
        $$LocationHistoryTableTableOrderingComposer,
        $$LocationHistoryTableTableAnnotationComposer,
        $$LocationHistoryTableTableCreateCompanionBuilder,
        $$LocationHistoryTableTableUpdateCompanionBuilder,
        (
          LocationHistoryData,
          BaseReferences<_$AppDatabase, $LocationHistoryTableTable,
              LocationHistoryData>
        ),
        LocationHistoryData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedConnectionTableTableTableManager get savedConnectionTable =>
      $$SavedConnectionTableTableTableManager(_db, _db.savedConnectionTable);
  $$LocationHistoryTableTableTableManager get locationHistoryTable =>
      $$LocationHistoryTableTableTableManager(_db, _db.locationHistoryTable);
}
