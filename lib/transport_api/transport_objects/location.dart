import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/enums/transport_vehicles.dart';

import '../enums/location_type.dart';
import 'coordinates.dart';

part 'location.g.dart';

@JsonSerializable()
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

  factory Location.fromJson(Map<String, dynamic> map) {
    map["coordinates"] ??= map["coordinate"];
    map.remove("coordinate");
    return _$LocationFromJson(map);
  }

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return "ID: $id, Type: ${type.name}, Name: $name, Score: $score, Coordinates: $coordinates, Distance: $distance, Icon: ${icon.name}";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Location &&
        other.id == id &&
        other.type == type &&
        other.name == name &&
        other.score == score &&
        other.coordinates == coordinates &&
        other.distance == distance &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return Object.hashAll([id, type, name, score, coordinates, distance, icon]);
  }
}
