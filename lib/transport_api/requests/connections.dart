import 'package:intl/intl.dart';
import 'package:sbb/transport_api/helper/bool_to_int.dart';
import 'package:sbb/transport_api/accessibility.dart';
import 'package:sbb/transport_api/requests/api_request.dart';

import '../transport_objects/connections.dart';
import '../transportation_vehicles.dart';

class ConnectionsRequest extends TransportApiRequest {
  @override
  final String apiUrl = 'https://transport.opendata.ch/v1/connections';

  ///Specifies the departure location of the connection.
  ///Example: 'Lausanne
  String from;

  ///Specifies the arrival location of the connection.
  ///Example: 'Genève'
  String to;

  ///Specifies up to five via locations.
  List<String>? via;

  ///Date of the connection
  DateTime? date;

  ///Time of the connection
  DateTime? time;

  ///defaults to false, if set to true the passed date and time is the arrival time
  bool? isArrivalTime;

  ///Transportation means; one or more of train, tram, ship, bus, cable way
  List<TransportationVehicles>? transportations;

  ///1 - 16. Specifies the number of connections to return.
  ///If several connections depart at the same time they are counted as 1.
  int? limit;

  ///0 - 3. Allows pagination of connections.
  ///Zero-based, so first page is 0, second is 1, third is 2 and so on.
  int? page;

  ///defaults to false, if set to true only direct connections are allowed
  bool? direct;

  ///defaults to false, if set to true only night trains containing beds are allowed, implies direct=true
  bool? sleeper;

  ///defaults to false, if set to true only night trains containing couchettes are allowed, implies direct=true
  bool? couchette;

  ///defaults to false, if set to true only trains allowing the transport of bicycles are allowed
  bool? bike;

  ///Possible values are independent_boarding, assisted_boarding, and advanced_notice
  Accessibility? accessibility;

  ConnectionsRequest(
      {required this.from,
      required this.to,
      this.via,
      this.date,
      this.time,
      this.isArrivalTime,
      this.transportations,
      this.limit,
      this.page,
      this.direct,
      this.sleeper,
      this.couchette,
      this.bike,
      this.accessibility}) {
    assert(via == null || via!.length <= 5);
    assert(page == null || (page! >= 0 && page! <= 3));
    assert(limit == null || (limit! >= 1 && limit! <= 16));
  }

  @override
  List<String> get parametersList {
    List<String> parametersList = ["from=$from", "to=$to"];
    if (via != null) {
      for (String stopover in via!) {
        parametersList.add("via[]=$stopover");
      }
    }
    if (date != null) {
      parametersList.add("date=${DateFormat("yyyy-MM-dd").format(date!)}");
    }
    if (time != null) {
      parametersList.add("time=${DateFormat("hh:mm").format(time!)}");
    }
    if (isArrivalTime != null) {
      parametersList.add("isArrivalTime=${isArrivalTime!.toInt()}");
    }
    if (transportations != null) {
      for (TransportationVehicles vehicle in transportations!) {
        parametersList.add("transportations[]=${vehicle.name}");
      }
    }
    if (limit != null) {
      parametersList.add("limit=$limit");
    }
    if (page != null) {
      parametersList.add("page=$page");
    }
    if (direct != null) {
      parametersList.add("direct=${direct!.toInt()}");
    }
    if (sleeper != null) {
      parametersList.add("sleeper=${sleeper!.toInt()}");
    }
    if (couchette != null) {
      parametersList.add("couchette=${couchette!.toInt()}");
    }
    if (bike != null) {
      parametersList.add("bike=${bike!.toInt()}");
    }
    if (accessibility != null) {
      parametersList.add("accessibility=${accessibility!.apiName}");
    }

    return parametersList;
  }

  Future<Connections> getConnections() async {
    Map<String, dynamic> jsonResponse = await getJsonResponse();
    return Connections.fromJson(jsonResponse);
  }
}
