// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class SavedConnectionTable extends Table
    with TableInfo<SavedConnectionTable, SavedConnectionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SavedConnectionTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<String> connection = GeneratedColumn<String>(
      'connection', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, connection];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_connection_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedConnectionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedConnectionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      connection: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}connection'])!,
    );
  }

  @override
  SavedConnectionTable createAlias(String alias) {
    return SavedConnectionTable(attachedDatabase, alias);
  }
}

class SavedConnectionTableData extends DataClass
    implements Insertable<SavedConnectionTableData> {
  final int id;
  final String connection;
  const SavedConnectionTableData({required this.id, required this.connection});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['connection'] = Variable<String>(connection);
    return map;
  }

  SavedConnectionTableCompanion toCompanion(bool nullToAbsent) {
    return SavedConnectionTableCompanion(
      id: Value(id),
      connection: Value(connection),
    );
  }

  factory SavedConnectionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedConnectionTableData(
      id: serializer.fromJson<int>(json['id']),
      connection: serializer.fromJson<String>(json['connection']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'connection': serializer.toJson<String>(connection),
    };
  }

  SavedConnectionTableData copyWith({int? id, String? connection}) =>
      SavedConnectionTableData(
        id: id ?? this.id,
        connection: connection ?? this.connection,
      );
  SavedConnectionTableData copyWithCompanion(
      SavedConnectionTableCompanion data) {
    return SavedConnectionTableData(
      id: data.id.present ? data.id.value : this.id,
      connection:
          data.connection.present ? data.connection.value : this.connection,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedConnectionTableData(')
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
      (other is SavedConnectionTableData &&
          other.id == this.id &&
          other.connection == this.connection);
}

class SavedConnectionTableCompanion
    extends UpdateCompanion<SavedConnectionTableData> {
  final Value<int> id;
  final Value<String> connection;
  const SavedConnectionTableCompanion({
    this.id = const Value.absent(),
    this.connection = const Value.absent(),
  });
  SavedConnectionTableCompanion.insert({
    this.id = const Value.absent(),
    required String connection,
  }) : connection = Value(connection);
  static Insertable<SavedConnectionTableData> custom({
    Expression<int>? id,
    Expression<String>? connection,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (connection != null) 'connection': connection,
    });
  }

  SavedConnectionTableCompanion copyWith(
      {Value<int>? id, Value<String>? connection}) {
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
      map['connection'] = Variable<String>(connection.value);
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

class LocationHistoryTable extends Table
    with TableInfo<LocationHistoryTable, LocationHistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LocationHistoryTable(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  late final GeneratedColumn<DateTime> lastSearched = GeneratedColumn<DateTime>(
      'last_searched', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  late final GeneratedColumn<int> searchCount = GeneratedColumn<int>(
      'search_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const CustomExpression('1'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, location, lastSearched, searchCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_history_table';
  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationHistoryTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationHistoryTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      lastSearched: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_searched'])!,
      searchCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}search_count'])!,
    );
  }

  @override
  LocationHistoryTable createAlias(String alias) {
    return LocationHistoryTable(attachedDatabase, alias);
  }
}

class LocationHistoryTableData extends DataClass
    implements Insertable<LocationHistoryTableData> {
  final int id;
  final String location;
  final DateTime lastSearched;
  final int searchCount;
  const LocationHistoryTableData(
      {required this.id,
      required this.location,
      required this.lastSearched,
      required this.searchCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['location'] = Variable<String>(location);
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

  factory LocationHistoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationHistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      location: serializer.fromJson<String>(json['location']),
      lastSearched: serializer.fromJson<DateTime>(json['lastSearched']),
      searchCount: serializer.fromJson<int>(json['searchCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'location': serializer.toJson<String>(location),
      'lastSearched': serializer.toJson<DateTime>(lastSearched),
      'searchCount': serializer.toJson<int>(searchCount),
    };
  }

  LocationHistoryTableData copyWith(
          {int? id,
          String? location,
          DateTime? lastSearched,
          int? searchCount}) =>
      LocationHistoryTableData(
        id: id ?? this.id,
        location: location ?? this.location,
        lastSearched: lastSearched ?? this.lastSearched,
        searchCount: searchCount ?? this.searchCount,
      );
  LocationHistoryTableData copyWithCompanion(
      LocationHistoryTableCompanion data) {
    return LocationHistoryTableData(
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
    return (StringBuffer('LocationHistoryTableData(')
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
      (other is LocationHistoryTableData &&
          other.id == this.id &&
          other.location == this.location &&
          other.lastSearched == this.lastSearched &&
          other.searchCount == this.searchCount);
}

class LocationHistoryTableCompanion
    extends UpdateCompanion<LocationHistoryTableData> {
  final Value<int> id;
  final Value<String> location;
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
    required String location,
    required DateTime lastSearched,
    this.searchCount = const Value.absent(),
  })  : location = Value(location),
        lastSearched = Value(lastSearched);
  static Insertable<LocationHistoryTableData> custom({
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
      Value<String>? location,
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
      map['location'] = Variable<String>(location.value);
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

class DatabaseAtV2 extends GeneratedDatabase {
  DatabaseAtV2(QueryExecutor e) : super(e);
  late final SavedConnectionTable savedConnectionTable =
      SavedConnectionTable(this);
  late final LocationHistoryTable locationHistoryTable =
      LocationHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [savedConnectionTable, locationHistoryTable];
  @override
  int get schemaVersion => 2;
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}
