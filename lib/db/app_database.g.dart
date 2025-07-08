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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedConnectionTableTable savedConnectionTable =
      $SavedConnectionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [savedConnectionTable];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedConnectionTableTableTableManager get savedConnectionTable =>
      $$SavedConnectionTableTableTableManager(_db, _db.savedConnectionTable);
}
