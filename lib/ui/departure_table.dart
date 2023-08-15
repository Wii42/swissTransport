import 'package:flutter/material.dart';
import 'package:sbb/ui/api_user.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/station_board.dart';

import '../transport_api/transport_objects/location.dart';
import '../transport_api/transport_objects/stop.dart';

class DepartureTable extends StatelessWidget {
  final String station;
  final TransportApi api;

  static const int widthConstraint = 500;
  static const double paddingInset = 5;
  static const double iconWidth = 20;

  const DepartureTable(
      {super.key, required this.station, this.api = const TransportApi()});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: ApiUser<StationBoard>(
        apiCall: api.stationBoard(station: station, limit: 10),
        onError: ApiUser.serverNotFound,
        displayResponse: (board) {
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
        return Table(
          border: const TableBorder(horizontalInside: BorderSide()),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: const IntrinsicColumnWidth(),
          columnWidths: const {
            0: FixedColumnWidth((iconWidth + (2 * paddingInset) + 40)),
            1: FixedColumnWidth(35 + (2 * paddingInset)),
          },
          children: [
            tableHeaders(wideView),
            for (Journey journey in board.stationBoard!)
              TableRow(
                children: [
                  padding(
                    transportIconAndName(journey),
                  ),
                  padding(
                    Text(journey.departureTimeString ?? ""),
                  ),
                  if (wideView) padding(stations(journey)),
                  padding(Text(
                    journey.to ?? "",
                    maxLines: wideView ? 1 : null,
                    overflow: TextOverflow.visible,
                  )),
                  padding(Text(journey.departurePlatform ?? "",
                      maxLines: 1, textAlign: TextAlign.end)),
                  padding(Text(journey.departurePlatformSection ?? "",
                      maxLines: 1)),
                ],
              )
          ],
        );
      },
    );
  }

  Wrap transportIconAndName(Journey journey) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: iconWidth,
          child: Icon(journey.transportVehicle?.icon, size: 14),
        ),
        Text(
          journey.transportName ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
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
      stationNames.join(', '),
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
}
