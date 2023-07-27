import 'package:flutter/material.dart';
import 'package:sbb/api_user.dart';
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ApiUser<StationBoard>(
          apiCall: api.stationBoard(station: station, limit: 5),
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
                if (board.stationBoard != null)
                  Table(
                    border: const TableBorder(horizontalInside: BorderSide()),
                    children: [
                      const TableRow(children: [
                        Text(""),
                        Text("Ab"),
                        Text("Richtung"),
                        Text("")
                      ]),
                      for (Journey journey in board.stationBoard!)
                        TableRow(
                          children: [
                            Text(
                              "${journey.category} ${journey.number}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(journey.departureTimeString ?? ""),
                            Text(journey.to ?? ""),
                            Text(journey.departurePlatform ?? "")
                          ],
                        )
                    ],
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
