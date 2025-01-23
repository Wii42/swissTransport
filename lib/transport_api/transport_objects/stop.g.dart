// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stop _$StopFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'station',
      'arrival',
      'departure',
      'delay',
      'platform',
      'prognosis',
      'arrivalTimestamp',
      'departureTimestamp',
      'realtimeAvailability',
      'location'
    ],
  );
  return Stop(
    station: json['station'] == null
        ? null
        : Location.fromJson(json['station'] as Map<String, dynamic>),
    arrival: json['arrival'] == null
        ? null
        : DateTime.parse(json['arrival'] as String),
    departure: json['departure'] == null
        ? null
        : DateTime.parse(json['departure'] as String),
    delay: (json['delay'] as num?)?.toInt(),
    platform: json['platform'] as String?,
    prognosis: json['prognosis'] == null
        ? null
        : Prognosis.fromJson(json['prognosis'] as Map<String, dynamic>),
    arrivalTimestamp: (json['arrivalTimestamp'] as num?)?.toInt(),
    departureTimestamp: (json['departureTimestamp'] as num?)?.toInt(),
    realtimeAvailability: json['realtimeAvailability'] as String?,
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StopToJson(Stop instance) => <String, dynamic>{
      'station': instance.station?.toJson(),
      'arrival': instance.arrival?.toIso8601String(),
      'departure': instance.departure?.toIso8601String(),
      'delay': instance.delay,
      'platform': instance.platform,
      'prognosis': instance.prognosis?.toJson(),
      'arrivalTimestamp': instance.arrivalTimestamp,
      'departureTimestamp': instance.departureTimestamp,
      'realtimeAvailability': instance.realtimeAvailability,
      'location': instance.location?.toJson(),
    };
