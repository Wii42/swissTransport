// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['type', 'x', 'y'],
  );
  return Coordinates(
    type: json['type'] as String?,
    x: (json['x'] as num?)?.toDouble(),
    y: (json['y'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'type': instance.type,
      'x': instance.x,
      'y': instance.y,
    };
