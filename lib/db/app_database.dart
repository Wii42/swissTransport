import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../transport_api/transport_objects/connection.dart';
import 'saved_connection_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SavedConnectionTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

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
}
