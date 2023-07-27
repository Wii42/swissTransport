import 'package:sbb/transport_api/transportation_vehicles.dart';

import 'coordinates.dart';

class Location {
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
  TransportationVehicles icon;

  Location({
    this.id,
    this.type = LocationType.none,
    this.name,
    this.score,
    this.coordinates,
    this.distance,
    this.icon = TransportationVehicles.none,
  });

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      type: map['type'] != null
          ? LocationType.fromJson(map['type'])
          : LocationType.none,
      name: map['name'],
      score: map['score'],
      coordinates: map['coordinate'] != null
          ? Coordinates.fromJson(map['coordinate'])
          : null,
      distance: map['distance'],
      icon: map['icon'] != null
          ? TransportationVehicles.fromJson(map['icon'])
          : TransportationVehicles.none,
    );
  }

  static Location? maybeFromJson(Map<String, dynamic>? map){
    if(map == null){
      return null;
    }
    return Location.fromJson(map);
  }

  static List<Location> multipleFromJson(List<dynamic> list) {
    return [for (Map<String, dynamic> map in list) Location.fromJson(map)];
  }

  static List<Location>? maybeMultipleFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return Location.multipleFromJson(list);
  }

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
    print("$string does not match any LocationType");
    return LocationType.none;
  }
}
