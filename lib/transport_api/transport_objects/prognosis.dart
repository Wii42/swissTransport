import 'json_coding/prognosis_coder.dart';

///A prognosis contains "realtime" information on the status of a connection checkpoint.
class Prognosis {
  static final PrognosisCoder jsonCoder = PrognosisCoder();

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
      jsonCoder.fromJson(map);

  static Prognosis? maybeFromJson(Map<String, dynamic>? map) =>
      jsonCoder.maybeFromJson(map);

  static List<Prognosis> multipleFromJson(List<dynamic> list) =>
      jsonCoder.multipleFromJson(list);

  static List<Prognosis>? maybeMultipleFromJson(List<dynamic>? list) =>
      jsonCoder.maybeMultipleFromJson(list);

  Map<String, dynamic> asJson() => jsonCoder.asJson(this);

  static List<Map<String, dynamic>> multipleAsJson(List<Prognosis> list) =>
      jsonCoder.multipleAsJson(list);

  static List<Map<String, dynamic>>? maybeMultipleAsJson(
          List<Prognosis>? list) =>
      jsonCoder.maybeMultipleAsJson(list);

  @override
  String toString() {
    return "Plattform: $platform, Departure: $departure, Arrival: $arrival, Capacity 1st class: $capacity1st, Capacity 2nd class: $capacity2nd";
  }
}
