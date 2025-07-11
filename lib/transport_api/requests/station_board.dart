import 'package:intl/intl.dart';
import 'package:sbb/transport_api/requests/api_request.dart';
import 'package:sbb/transport_api/enums/transport_vehicles.dart';

import '../transport_objects/station_board.dart';

///Returns the next connections leaving from a specific location.
class StationBoardRequest extends TransportApiRequest {
  @override
  final String apiEndpoint = "stationboard";

  ///Specifies the location of which a station board should be returned
  String? station;

  ///The id of the station whose station board should be returned.
  /// Alternative to the station parameter; one of these two is required.
  /// If both an id and a station are specified the id has precedence.
  String? id;

  ///Number of departing connections to return.
  /// This is not a hard limit - if multiple connections leave at the same time it'll return any connections that leave at the same time as the last connection within the limit.
  /// For example: limit=4 will return connections leaving at :
  ///
  ///     19:30
  ///     19:32
  ///     19:32
  ///     19:35
  ///     19:35
  ///
  /// Because one of the connections leaving at 19:35 is within the limit, all connections leaving at 19:35 are shown.
  int? limit;

  ///Transportation means; one or more of train, tram, ship, bus, cable way
  List<TransportVehicles>? transportations;

  ///Date and time of departing connections
  DateTime? datetime;

  ///departure (default) or arrival
  StationBoardType? type;

  StationBoardRequest({
    this.station,
    this.id,
    this.limit,
    this.transportations,
    this.datetime,
    this.type,
  }) {
    assert(station != null || id != null);
  }

  @override
  Map<String, dynamic> get queryParameters {
    Map<String, dynamic> parametersList = {};
    if (station != null) {
      parametersList["station"] = station;
    }
    if (id != null) {
      parametersList["id"] = id;
    }
    if (limit != null) {
      parametersList["limit"] = limit.toString();
    }
    if (transportations != null) {
      parametersList["transportations"] =
          transportations!.map((e) => e.name).toList();
    }
    if (datetime != null) {
      parametersList["datetime"] =
          DateFormat("yyyy-MM-dd hh:mm").format(datetime!);
    }
    if (type != null) {
      parametersList["type"] = type!.name;
    }

    return parametersList;
  }

  Future<StationBoard> getStationBoard() async {
    Map<String, dynamic> jsonResponse = await getJsonResponse();
    return StationBoard.fromJson(jsonResponse);
  }
}

enum StationBoardType { departure, arrival }
