import 'package:flutter/material.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/helper/go_subroute_extension.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/station_board.dart';
import 'package:sbb/ui/api_user.dart';
import 'package:sbb/ui/routes.dart';

import '../transport_api/transport_objects/section.dart';
import '../transport_api/transport_objects/stop.dart';

class DepartureDataTable extends StatelessWidget {
  final String station;
  final TransportApi api;
  final int limit;

  static const int widthConstraint = 500;
  static const double paddingInset = 5;
  static const double iconWidth = 20;

  const DepartureDataTable(
      {super.key,
      required this.station,
      this.api = const TransportApi(),
      this.limit = 10});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: ApiUser<StationBoard>(
        apiCall: api.stationBoard(station: station, limit: limit),
        onError: ApiUser.serverNotFound,
        displayResponse: (context, board) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                spacing: 5,
                children: [
                  const Text("Abfahrtstabelle ab:"),
                  Text(
                    board.station?.name ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              if (board.stationBoard != null) departureTable(board)
            ],
          );
        },
      ),
    );
  }

  Widget departureTable(StationBoard board) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool wideView = isWideView(constraints);
        return DataTable(
          columnSpacing: 15,
          horizontalMargin: 5,
          columns: columns(wideView),
          rows: tableRows(board, context, wideView),
        );
      },
    );
  }

  List<DataRow> tableRows(
      StationBoard board, BuildContext context, bool wideView) {
    List<DataRow> rows = [];
    for (Journey journey in board.stationBoard!) {
      details() => showDetails(journey, context);
      rows.add(
        DataRow(
          cells: [
            DataCell(
              transportIconAndName(journey),
              onTap: details,
            ),
            DataCell(
              Text(journey.departureTimeString ?? ""),
              onTap: details,
            ),
            if (wideView)
              DataCell(
                stations(journey),
                onTap: details,
              ),
            DataCell(
              Text(
                journey.to ?? "",
                maxLines: wideView ? 1 : null,
                overflow: TextOverflow.visible,
                softWrap: !wideView,
              ),
              onTap: details,
            ),
            DataCell(
              Text(journey.departurePlatform ?? "",
                  style: journey.hasDeparturePlatformChanged()
                      ? TimeAndStopsRow.unplannedChangeStyle
                      : null,
                  maxLines: 1,
                  textAlign: TextAlign.end),
              onTap: details,
            ),
            DataCell(
              Text(journey.departurePlatformSection ?? "",
                  style: journey.hasDeparturePlatformChanged()
                      ? TimeAndStopsRow.unplannedChangeStyle
                      : null,
                  maxLines: 1),
              onTap: details,
            ),
          ],
        ),
      );
    }
    return rows;
  }

  List<DataColumn> columns(bool wideView) {
    return [
      const DataColumn(label: SizedBox()),
      const DataColumn(label: Text('Ab')),
      if (wideView) const DataColumn(label: Text('Stationen')),
      const DataColumn(label: Text('Richtung')),
      const DataColumn(label: Text('Gl.'), numeric: true),
      const DataColumn(label: SizedBox()),
    ];
  }

  Widget transportIconAndName(Journey journey) {
    return RichText(
        maxLines: 1,
        text: TextSpan(
          //crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            WidgetSpan(
              child: SizedBox(
                width: iconWidth,
                height: iconWidth,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(journey.transportVehicle?.icon, size: 14)),
              ),
            ),
            TextSpan(
              text: journey.transportName ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Widget stations(Journey journey) {
    List<Stop> stationsList = journey.passList ?? <Stop>[];
    List<String> stationNames = [];
    for (int i = 0; i < stationsList.length; i++) {
      Stop stop = stationsList[i];
      String? name = stop.station?.name;
      if (name != null) {
        if (name != journey.to || i < stationsList.length - 1) {
          stationNames.add(name);
        }
      }
    }

    return Text(
      stationNames.join('    '),
      softWrap: false,
      overflow: TextOverflow.fade,
    );
  }

  TableRow tableHeaders(bool isWideView) {
    return TableRow(
      children: [
        const SizedBox(),
        padding(const Text("Ab")),
        if (isWideView) padding(const Text('Stationen')),
        padding(const Text("Richtung")),
        padding(const Text("Gleis", textAlign: TextAlign.end)),
        const SizedBox(),
      ],
    );
  }

  Widget padding(Widget? widget) =>
      Padding(padding: const EdgeInsets.all(paddingInset), child: widget);

  bool isWideView(BoxConstraints constraints) =>
      constraints.maxWidth > widthConstraint;

  void showDetails(Journey journey, BuildContext context) => context
      .pushSubRoute(Routes.journey.string, extra: Section(journey: journey));
}
