// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'id',
      'type',
      'name',
      'score',
      'coordinates',
      'distance',
      'icon'
    ],
  );
  return Location(
    id: json['id'] as String?,
    type: json['type'] == null
        ? LocationType.none
        : LocationType.fromJson(json['type'] as String),
    name: json['name'] as String?,
    score: (json['score'] as num?)?.toInt(),
    coordinates: json['coordinates'] == null
        ? null
        : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
    distance: (json['distance'] as num?)?.toInt(),
    icon: json['icon'] == null
        ? TransportVehicles.none
        : TransportVehicles.fromJson(json['icon'] as String),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$LocationTypeEnumMap[instance.type]!,
      'name': instance.name,
      'score': instance.score,
      'coordinates': instance.coordinates?.toJson(),
      'distance': instance.distance,
      'icon': _$TransportVehiclesEnumMap[instance.icon]!,
    };

const _$LocationTypeEnumMap = {
  LocationType.all: 'all',
  LocationType.station: 'station',
  LocationType.poi: 'poi',
  LocationType.address: 'address',
  LocationType.refine: 'refine',
  LocationType.none: 'none',
};

const _$TransportVehiclesEnumMap = {
  TransportVehicles.bus: 'bus',
  TransportVehicles.train: 'train',
  TransportVehicles.tram: 'tram',
  TransportVehicles.ship: 'ship',
  TransportVehicles.cableWay: 'cableWay',
  TransportVehicles.none: 'none',
};
