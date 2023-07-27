///A prognosis contains "realtime" information on the status of a connection checkpoint.
class Prognosis {
  ///The estimated arrival/departure platform
  String? plattform;

  ///The departure time prognosis to the checkpoint
  DateTime? departure;

  ///The arrival time prognosis to the checkpoint
  DateTime? arrival;

  ///The estimated occupation load of 1st class coaches
  int? capacity1st;

  ///The estimated occupation load of 2nd class coaches
  int? capacity2nd;

  Prognosis(
      {this.plattform,
      this.departure,
      this.arrival,
      this.capacity1st,
      this.capacity2nd});

  factory Prognosis.fromJson(Map<String, dynamic> map) {
    return Prognosis(
      plattform: map['plattform'],
      departure:
          map['departure'] != null ? DateTime.parse(map['departure']) : null,
      arrival: map['arrival'] != null ? DateTime.parse(map['arrival']) : null,
      capacity1st: map['capacity1st'],
      capacity2nd: map['capacity2nd'],
    );
  }

  static Prognosis? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return Prognosis.fromJson(map);
  }

  @override
  String toString() {
    return "Plattform: $plattform, Departure: $departure, Arrival: $arrival, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd";
  }
}
