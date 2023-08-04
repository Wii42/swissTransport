import 'package:sbb/transport_api/requests/connections.dart';
import 'package:sbb/transport_api/requests/station_board.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/transport_api/transport_objects/coordinates.dart';
import 'package:sbb/transport_api/requests/locations.dart';
import 'package:sbb/transport_api/transport_objects/station_board.dart';
import 'package:sbb/transport_api/transport_objects/stations.dart';
import 'package:sbb/transport_api/enums/transport_vehicles.dart';

import 'enums/accessibility.dart';
import 'enums/location_type.dart';

const String locationsUrl = "https://transport.opendata.ch/v1/locations";

class TransportApi {
  const TransportApi();

  Future<Stations> locations(
      {String? query, Coordinates? coordinates, LocationType? type}) async {
    LocationsRequest request =
        LocationsRequest(query: query, coordinates: coordinates, type: type);
    return request.getLocations();
  }

  Future<Connections> connections(
      {required String from,
      required String to,
      List<String>? via,
      DateTime? date,
      DateTime? time,
      bool? isArrivalTime,
      List<TransportVehicles>? transportations,
      int? limit,
      int? page,
      bool? direct,
      bool? sleeper,
      bool? couchette,
      bool? bike,
      Accessibility? accessibility}) async {
    ConnectionsRequest request = ConnectionsRequest(
        from: from,
        to: to,
        via: via,
        date: date,
        time: time,
        isArrivalTime: isArrivalTime,
        transportations: transportations,
        limit: limit,
        page: page,
        direct: direct,
        sleeper: sleeper,
        couchette: couchette,
        bike: bike,
        accessibility: accessibility);
    Connections connections = await request.getConnections();
    //print(connections.connections);
    return connections;
  }

  Future<StationBoard> stationBoard({
    String? station,
    String? id,
    int? limit,
    List<TransportVehicles>? transportations,
    DateTime? datetime,
    StationBoardType? type,
  }) {
    StationBoardRequest request = StationBoardRequest(
        station: station,
        id: id,
        limit: limit,
        transportations: transportations,
        datetime: datetime,
        type: type);
    return request.getStationBoard();
  }
}
