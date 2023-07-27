import 'package:sbb/transport_api/transport_objects/location.dart';

import 'journey.dart';

class StationBoard {
  Location? station;
  List<Journey>? stationBoard;

  StationBoard({this.station, this.stationBoard});

  factory StationBoard.fromJson(Map<String, dynamic> map) {
    return StationBoard(
      station: Location.maybeFromJson(map['station']),
      stationBoard: Journey.maybeMultipleFromJson(map['stationboard']),
    );
  }

  static StationBoard? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return StationBoard.fromJson(map);
  }
}
