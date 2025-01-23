// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Connection _$ConnectionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'from',
      'to',
      'duration',
      'transfers',
      'service',
      'products',
      'capacity1st',
      'capacity2nd',
      'sections'
    ],
  );
  return Connection(
    from: json['from'] == null
        ? null
        : Stop.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : Stop.fromJson(json['to'] as Map<String, dynamic>),
    duration: _$JsonConverterFromJson<String, Duration>(
        json['duration'], const DurationParseConverter().fromJson),
    transfers: (json['transfers'] as num?)?.toInt(),
    service: json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
    products:
        (json['products'] as List<dynamic>?)?.map((e) => e as String).toList(),
    capacity1st: (json['capacity1st'] as num?)?.toInt(),
    capacity2nd: (json['capacity2nd'] as num?)?.toInt(),
    sections: (json['sections'] as List<dynamic>?)
        ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConnectionToJson(Connection instance) =>
    <String, dynamic>{
      'from': instance.from?.toJson(),
      'to': instance.to?.toJson(),
      'duration': _$JsonConverterToJson<String, Duration>(
          instance.duration, const DurationParseConverter().toJson),
      'transfers': instance.transfers,
      'service': instance.service?.toJson(),
      'products': instance.products,
      'capacity1st': instance.capacity1st,
      'capacity2nd': instance.capacity2nd,
      'sections': instance.sections?.map((e) => e.toJson()).toList(),
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
