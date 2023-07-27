import 'package:sbb/transport_api/transport_objects/coordinates.dart';
import 'package:sbb/transport_api/requests/api_request.dart';

import '../transport_objects/location.dart';
import '../transport_objects/stations.dart';

class LocationsRequest extends TransportApiRequest {
  @override
  final String apiUrl = "https://transport.opendata.ch/v1/locations";

  ///Specifies the location name to search for
  String? query;

  Coordinates? coordinates;

  ///Only with query parameter. Specifies the location type, possible types are:
  ///
  ///     all (default): Looks up for all types of locations
  ///     station: Looks up for stations (train station, bus station)
  ///     poi: Looks up for points of interest (Clock tower, China garden)
  ///     address: Looks up for an address (Zurich Bahnhofstrasse 33)
  LocationType? type;

  LocationsRequest({this.query, this.coordinates, this.type}) {
    assert(
      query != null ||
          (coordinates != null &&
              coordinates!.x != null &&
              coordinates!.y != null),
    );
  }

  @override
  List<String> get parametersList {
    List<String> parametersList = [];
    if (query != null) {
      parametersList.add("query=$query");
    }
    if (coordinates != null) {
      if (coordinates!.x != null) {
        parametersList.add("x=${coordinates!.x}");
      }
      if (coordinates!.y != null) {
        parametersList.add("y=${coordinates!.y}");
      }
    }
    if (type != null) {
      parametersList.add("type=${type!.name}");
    }
    return parametersList;
  }

  Future<Stations> getLocations() async {
    Map<String, dynamic> jsonResponse = await getJsonResponse();
    return Stations.fromJson(jsonResponse['stations']);
  }
}
