import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbb/transport_api/helper/bool_to_int.dart';
import 'package:sbb/transport_api/enums/accessibility.dart';
import 'package:sbb/transport_api/requests/api_request.dart';

import '../transport_objects/connections.dart';
import '../enums/transport_vehicles.dart';

class ConnectionsRequest extends TransportApiRequest {
  @override
  final String apiEndpoint = 'connections';

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
  TimeOfDay? time;

  ///defaults to false, if set to true the passed date and time is the arrival time
  bool? isArrivalTime;

  ///Transportation means; one or more of train, tram, ship, bus, cable way
  List<TransportVehicles>? transportations;

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
  Map<String, dynamic> get queryParameters {
    Map<String, dynamic> parametersList = {"from": from, "to": to};
    if (via != null) {
      parametersList["via[]"] = via;
    }
    if (date != null) {
      parametersList["date"] = DateFormat("yyyy-MM-dd").format(date!);
    }
    if (time != null) {
      parametersList["time"] = DateFormat("HH:mm")
          .format(DateTime(0, 0, 0, time!.hour, time!.minute));
    }
    if (isArrivalTime != null) {
      parametersList["isArrivalTime"] = isArrivalTime!.toInt().toString();
    }
    if (transportations != null) {
      parametersList["transportations[]"] =
          transportations!.map((e) => e.name).toList();
    }
    if (limit != null) {
      parametersList["limit"] = limit.toString();
    }
    if (page != null) {
      parametersList["page"] = page.toString();
    }
    if (direct != null) {
      parametersList["direct"] = direct!.toInt().toString();
    }
    if (sleeper != null) {
      parametersList["sleeper"] = sleeper!.toInt().toString();
    }
    if (couchette != null) {
      parametersList["couchette"] = couchette!.toInt().toString();
    }
    if (bike != null) {
      parametersList["bike"] = bike!.toInt().toString();
    }
    if (accessibility != null) {
      parametersList["accessibility"] = accessibility!.apiName;
    }

    return parametersList;
  }

  Future<Connections> getConnections() async {
    Map<String, dynamic> jsonResponse = await getJsonResponse();
    return Connections.fromJson(jsonResponse);
  }
}
