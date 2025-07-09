import 'dart:convert';

import 'package:drift/drift.dart';

import '../transport_api/transport_objects/location.dart';

@DataClassName("LocationHistoryData")
class LocationHistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get location => text().map(const LocationConverter()).unique()();

  DateTimeColumn get lastSearched => dateTime()();
  IntColumn get searchCount => integer().withDefault(const Constant(1))();
}

class LocationConverter extends TypeConverter<Location, String>
    with JsonTypeConverter2<Location, String, Map<String, dynamic>> {
  const LocationConverter();

  @override
  Location fromSql(String fromDb) => fromJson(jsonDecode(fromDb));

  @override
  String toSql(Location value) => jsonEncode(toJson(value));

  @override
  Location fromJson(Map<String, dynamic> json) => Location.fromJson(json);

  @override
  Map<String, dynamic> toJson(Location value) => value.toJson();
}
