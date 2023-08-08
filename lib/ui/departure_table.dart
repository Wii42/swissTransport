import 'package:flutter/material.dart';
import 'package:sbb/ui/api_user.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/journey.dart';
import 'package:sbb/transport_api/transport_objects/station_board.dart';

class DepartureTable extends StatelessWidget {
  final String station;
  final TransportApi api;

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

  Table departureTable(StationBoard board) {
    return Table(
      border: const TableBorder(horizontalInside: BorderSide()),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        tableHeaders(),
        for (Journey journey in board.stationBoard!)
          TableRow(
            children: [
              padding(
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      child: Icon(journey.transportVehicle?.icon, size: 14),
                    ),
                    Text(
                      journey.transportName ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              padding(
                Text(journey.departureTimeString ?? ""),
              ),
              padding(
                Text(journey.to ?? ""),
              ),
              padding(
                Text(
                  journey.departurePlatform ?? "",
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          )
      ],
    );
  }

  TableRow tableHeaders() {
    return TableRow(children: [
      const SizedBox(),
      padding(const Text("Ab")),
      padding(const Text("Richtung")),
      padding(const Text("Gleis", textAlign: TextAlign.end)),
    ]);
  }

  Widget padding(Widget? widget) =>
      Padding(padding: const EdgeInsets.all(5), child: widget);
}
