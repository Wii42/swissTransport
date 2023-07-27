import 'package:sbb/transport_api/requests/locations.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

import 'connection.dart';

class Connections {
  List<Connection>? connections;
  Location? from;
  Location? to;

  Connections({this.connections, this.from, this.to});

  factory Connections.fromJson(Map<String, dynamic> map) {
    return Connections(
      connections: Connection.maybeMultipleFromJson(map['connections']),
      from: Location.maybeFromJson(map['from']),
      to: Location.maybeFromJson(map['to']),
    );
  }

  static Connections? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Connections.fromJson(map);
  }
}
