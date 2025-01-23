import 'package:sbb/transport_api/transport_objects/coordinates.dart';
import 'package:sbb/transport_api/requests/api_request.dart';

import '../enums/location_type.dart';
import '../transport_objects/stations.dart';

class LocationsRequest extends TransportApiRequest {
  @override
  final String apiEndpoint = "locations";

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
  Map<String, dynamic> get queryParameters {
    Map<String, dynamic> parametersList = {};
    if (query != null) {
      parametersList["query"] = query;
    }
    if (coordinates != null) {
      if (coordinates!.x != null) {
        parametersList["x"] = coordinates!.x.toString();
      }
      if (coordinates!.y != null) {
        parametersList["y"] = coordinates!.y.toString();
      }
    }
    if (type != null) {
      parametersList["type"] = type!.name;
    }
    return parametersList;
  }

  Future<Stations> getLocations() async {
    Map<String, dynamic> jsonResponse = await getJsonResponse();
    return Stations.fromJson(jsonResponse['stations']);
  }
}
