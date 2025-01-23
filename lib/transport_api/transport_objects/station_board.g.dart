// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationBoard _$StationBoardFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['station', 'stationboard'],
  );
  return StationBoard(
    station: json['station'] == null
        ? null
        : Location.fromJson(json['station'] as Map<String, dynamic>),
    stationBoard: (json['stationboard'] as List<dynamic>?)
        ?.map((e) => Journey.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StationBoardToJson(StationBoard instance) =>
    <String, dynamic>{
      'station': instance.station?.toJson(),
      'stationboard': instance.stationBoard?.map((e) => e.toJson()).toList(),
    };
