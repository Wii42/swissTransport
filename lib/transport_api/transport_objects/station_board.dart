import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

import 'journey.dart';

part 'station_board.g.dart';

@JsonSerializable()
class StationBoard {
  Location? station;
  @JsonKey(name: 'stationboard')
  List<Journey>? stationBoard;

  StationBoard({this.station, this.stationBoard});

  factory StationBoard.fromJson(Map<String, dynamic> map) => _$StationBoardFromJson(map);

  Map<String, dynamic> toJson() => _$StationBoardToJson(this);

  @override
  String toString() {
    return "Station: $station, StationBoard: $stationBoard";
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StationBoard && other.station == station && ListEquality().equals(other.stationBoard, stationBoard);
  }

  @override
  int get hashCode => Object.hashAll([station, ListEquality().hash(stationBoard)]);
}
