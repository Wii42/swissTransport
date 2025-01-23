// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stations _$StationsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['stations'],
  );
  return Stations(
    stations: (json['stations'] as List<dynamic>)
        .map((e) => Location.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StationsToJson(Stations instance) => <String, dynamic>{
      'stations': instance.stations.map((e) => e.toJson()).toList(),
    };
