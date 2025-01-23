// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['journey', 'walk', 'departure', 'arrival'],
  );
  return Section(
    journey: json['journey'] == null
        ? null
        : Journey.fromJson(json['journey'] as Map<String, dynamic>),
    walk: json['walk'] == null
        ? null
        : Walk.fromJson(json['walk'] as Map<String, dynamic>),
    departure: json['departure'] == null
        ? null
        : Stop.fromJson(json['departure'] as Map<String, dynamic>),
    arrival: json['arrival'] == null
        ? null
        : Stop.fromJson(json['arrival'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'journey': instance.journey?.toJson(),
      'walk': instance.walk?.toJson(),
      'departure': instance.departure?.toJson(),
      'arrival': instance.arrival?.toJson(),
    };
