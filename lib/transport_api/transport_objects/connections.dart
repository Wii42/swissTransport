import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

import 'connection.dart';

part 'connections.g.dart';

@JsonSerializable()
class Connections {
  List<Connection>? connections;
  Location? from;
  Location? to;
  @Deprecated("Not documented in the API, seems to be duplicate of from/to")
  Map<String, List<Location>> stations;

  Connections({this.connections, this.from, this.to, this.stations = const {}});

  factory Connections.fromJson(Map<String, dynamic> map) =>
      _$ConnectionsFromJson(map);

  Map<String, dynamic> toJson() => _$ConnectionsToJson(this);
}
