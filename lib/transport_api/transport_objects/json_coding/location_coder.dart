import 'package:sbb/transport_api/transport_objects/json_coding/json_coder.dart';

import '../../transportation_vehicles.dart';
import '../coordinates.dart';
import '../location.dart';

class LocationCoder extends JsonCoder<Location> {
  static const String idKey = 'id',
      typeKey = 'type',
      nameKey = 'name',
      scoreKey = 'score',
      coordinatesKey = 'coordinates',
      distanceKey = 'distance',
      iconKey = 'icon';

  @override
  Location fromJson(Map<String, dynamic> map) {
    return Location(
      id: map[idKey],
      type: LocationType.maybeFromJson(map[typeKey]),
      name: map[nameKey],
      score: map[scoreKey],
      coordinates: Coordinates.maybeFromJson(map[coordinatesKey]),
      distance: map[distanceKey],
      icon: TransportVehicles.maybeFromJson(map[iconKey]),
    );
  }

  @override
  Map<String, dynamic> asJson(Location object) {
    return {
      idKey: object.id,
      typeKey: object.type.name,
      nameKey: object.name,
      scoreKey: object.score,
      coordinatesKey: object.coordinates?.asJson(),
      distanceKey: object.distance,
      iconKey: object.icon.apiName,
    };
  }
}
