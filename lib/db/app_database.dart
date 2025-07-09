import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../transport_api/transport_objects/connection.dart';
import '../transport_api/transport_objects/location.dart';
import 'app_database.steps.dart';
import 'location_history_table.dart';
import 'saved_connection_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SavedConnectionTable, LocationHistoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  Future<SavedConnection> addSavedConnection(Connection connection) {
    return into(savedConnectionTable).insertReturning(
        SavedConnectionTableCompanion.insert(connection: connection));
  }

  Future<int> removeSavedConnection(SavedConnection savedConnection) {
    return managers.savedConnectionTable
        .filter((f) => f.id(savedConnection.id))
        .delete();
  }

  Future<List<SavedConnection>> getAllSavedConnections() {
    return select(savedConnectionTable).get();
  }

  Future<int> clearSavedConnections() {
    return delete(savedConnectionTable).go();
  }

  Future<LocationHistoryData> addLocationHistory(Location location,
      {DateTime? lastSearched}) {
    return into(locationHistoryTable).insertReturning(
        LocationHistoryTableCompanion.insert(
            location: location, lastSearched: lastSearched ?? DateTime.now()));
  }

  Future<int> updateLocationHistory(int id,
      {required int count, required DateTime lastSearched}) {
    return managers.locationHistoryTable.filter((f) => f.id(id)).update(
        (o) => o(searchCount: Value(count), lastSearched: Value(lastSearched)));
  }

  Future<int> incrementLocationHistoryCount(
      LocationHistoryData locationHistoryData,
      {DateTime? lastSearched}) {
    return updateLocationHistory(locationHistoryData.id,
        count: locationHistoryData.searchCount + 1,
        lastSearched: lastSearched ?? DateTime.now());
  }

  Future<List<LocationHistoryData>> getAllLocationHistory() {
    return select(locationHistoryTable).get();
  }

  Future<int> clearLocationHistory() {
    return delete(locationHistoryTable).go();
  }

  Future<int> removeLocationHistory(LocationHistoryData locationHistoryData) {
    return managers.locationHistoryTable
        .filter((f) => f.id(locationHistoryData.id))
        .delete();
  }

  @override
  MigrationStrategy get migration {
    Future<void> nukeTable(Migrator m, TableInfo<Table, dynamic> table) async {
      await m.deleteTable(table.actualTableName);
      await m.createTable(table);
    }

    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.createTable(schema.locationHistoryTable);
          await nukeTable(m, schema.savedConnectionTable);
        },
      ),
    );
  }
}
