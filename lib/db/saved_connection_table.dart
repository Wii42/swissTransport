import 'dart:convert';

import 'package:drift/drift.dart';

import '../transport_api/transport_objects/connection.dart';

@DataClassName("SavedConnection")
class SavedConnectionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get connection => text().map(const ConnectionConverter())();
}

class ConnectionConverter extends TypeConverter<Connection, String>
    with JsonTypeConverter2<Connection, String, Map<String, dynamic>> {
  const ConnectionConverter();

  @override
  Connection fromSql(String fromDb) => fromJson(jsonDecode(fromDb));

  @override
  String toSql(Connection value) => jsonEncode(toJson(value));

  @override
  Connection fromJson(Map<String, dynamic> json) => Connection.fromJson(json);

  @override
  Map<String, dynamic> toJson(Connection value) => value.toJson();
}
