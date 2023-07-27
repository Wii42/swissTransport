import 'package:sbb/transport_api/transport_objects/location.dart';

class Stations {
  ///  	A list of locations
  List<Location> stations;

  Stations({required this.stations});

  factory Stations.fromJson(List<dynamic> list) {
    return Stations(
      stations: Location.multipleFromJson(list),
    );
  }

  static Stations? maybeFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return Stations.fromJson(list);
  }
}
