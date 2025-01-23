// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Connections _$ConnectionsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['connections', 'from', 'to', 'stations'],
  );
  return Connections(
    connections: (json['connections'] as List<dynamic>?)
        ?.map((e) => Connection.fromJson(e as Map<String, dynamic>))
        .toList(),
    from: json['from'] == null
        ? null
        : Location.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : Location.fromJson(json['to'] as Map<String, dynamic>),
    stations: (json['stations'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => Location.fromJson(e as Map<String, dynamic>))
                  .toList()),
        ) ??
        const {},
  );
}

Map<String, dynamic> _$ConnectionsToJson(Connections instance) =>
    <String, dynamic>{
      'connections': instance.connections?.map((e) => e.toJson()).toList(),
      'from': instance.from?.toJson(),
      'to': instance.to?.toJson(),
      'stations': instance.stations
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
    };
