import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

part 'stations.g.dart';

@JsonSerializable()
class Stations {
  ///  	A list of locations
  List<Location> stations;

  Stations({required this.stations});

  factory Stations.fromJson(List<dynamic> list) =>
      _$StationsFromJson({"stations": list});

  Map<String, dynamic> toJson() => _$StationsToJson(this);

  @override
  String toString() {
    return "Stations: $stations";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Stations && ListEquality().equals(other.stations, stations);
  }

  @override
  int get hashCode => ListEquality().hash(stations);
}
