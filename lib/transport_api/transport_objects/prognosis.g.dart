// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prognosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prognosis _$PrognosisFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'platform',
      'departure',
      'arrival',
      'capacity1st',
      'capacity2nd'
    ],
  );
  return Prognosis(
    platform: json['platform'] as String?,
    departure: json['departure'] == null
        ? null
        : DateTime.parse(json['departure'] as String),
    arrival: json['arrival'] == null
        ? null
        : DateTime.parse(json['arrival'] as String),
    capacity1st: (json['capacity1st'] as num?)?.toInt(),
    capacity2nd: (json['capacity2nd'] as num?)?.toInt(),
  );
}

Map<String, dynamic> _$PrognosisToJson(Prognosis instance) => <String, dynamic>{
      'platform': instance.platform,
      'departure': instance.departure?.toIso8601String(),
      'arrival': instance.arrival?.toIso8601String(),
      'capacity1st': instance.capacity1st,
      'capacity2nd': instance.capacity2nd,
    };
