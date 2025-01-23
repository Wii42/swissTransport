import 'package:json_annotation/json_annotation.dart';

part 'prognosis.g.dart';

///A prognosis contains "realtime" information on the status of a connection checkpoint.
@JsonSerializable()
class Prognosis {
  ///The estimated arrival/departure platform
  String? platform;

  ///The departure time prognosis to the checkpoint
  DateTime? departure;

  ///The arrival time prognosis to the checkpoint
  DateTime? arrival;

  ///The estimated occupation load of 1st class coaches
  int? capacity1st;

  ///The estimated occupation load of 2nd class coaches
  int? capacity2nd;

  Prognosis(
      {this.platform,
      this.departure,
      this.arrival,
      this.capacity1st,
      this.capacity2nd});

  factory Prognosis.fromJson(Map<String, dynamic> map) =>
      _$PrognosisFromJson(map);

  Map<String, dynamic> toJson() => _$PrognosisToJson(this);

  @override
  String toString() {
    return "Plattform: $platform, Departure: $departure, Arrival: $arrival, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Prognosis &&
        other.platform == platform &&
        other.departure == departure &&
        other.arrival == arrival &&
        other.capacity1st == capacity1st &&
        other.capacity2nd == capacity2nd;
  }

  @override
  int get hashCode =>
      Object.hashAll([platform, departure, arrival, capacity1st, capacity2nd]);
}
