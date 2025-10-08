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
      type: DriftSqlType.string, requiredDuringInsert: true);
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final SavedConnectionTable savedConnectionTable =
      SavedConnectionTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedConnectionTable];
  @override
  int get schemaVersion => 1;
}
