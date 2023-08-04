import 'package:sbb/transport_api/transportation_vehicles.dart';

import 'coordinates.dart';
import 'json_coding/location_coder.dart';

class Location {
  static final LocationCoder jsonCoder = LocationCoder();

  ///The id of the location
  String? id;

  ///Type of the location, can contain:
  ///
  ///     station: Location is a train station, bus station
  ///     poi: Location is a point of interest (Clock tower, China garden)
  ///     address: Location is an address
  ///     refine: Location is not defined, the user has to relocate
  LocationType type;

  ///The location name
  String? name;

  ///The accuracy of the result
  int? score;

  ///The location coordinates
  Coordinates? coordinates;

  ///If search has been with coordinates, distance to original point in meters
  int? distance;
  TransportVehicles icon;

  Location({
    this.id,
    this.type = LocationType.none,
    this.name,
    this.score,
    this.coordinates,
    this.distance,
    this.icon = TransportVehicles.none,
  });

  factory Location.fromJson(Map<String, dynamic> map) =>
      jsonCoder.fromJson(map);

  static Location? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Location> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Location>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Location> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(
          List<Location>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "ID: $id, Type: ${type.name}, Name: $name, Score: $score, Coordinates: $coordinates, Distance: $distance, Icon: ${icon.name}";
  }
}

enum LocationType {
  ///Looks up for all types of locations
  all,

  /// Location is a train station, bus station
  station,

  ///Location is a point of interest (Clock tower, China garden)
  poi,

  /// Location is an address
  address,

  ///Location is not defined, the user has to relocate
  refine,
  none;

  factory LocationType.fromJson(String string) {
    for (LocationType icon in values) {
      if (icon.name == string) {
        return icon;
      }
    }
    return LocationType.none;
  }

  static LocationType maybeFromJson(String? string) {
    if (string == null) {
      return LocationType.none;
    }
    return LocationType.fromJson(string);
  }
}
