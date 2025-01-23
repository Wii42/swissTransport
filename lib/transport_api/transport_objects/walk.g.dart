// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Walk _$WalkFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['duration'],
  );
  return Walk(
    duration: _$JsonConverterFromJson<int, Duration>(
        json['duration'], const DurationInSecondsConverter().fromJson),
  );
}

Map<String, dynamic> _$WalkToJson(Walk instance) => <String, dynamic>{
      'duration': _$JsonConverterToJson<int, Duration>(
          instance.duration, const DurationInSecondsConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
