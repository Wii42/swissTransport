import 'package:flutter/material.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/connections_page/travel_duration_row.dart';
import 'package:sbb/ui/saved_connections.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import '../connections_page/connections_list.dart';
import '../ui/from_to_text.dart';
import '../generic_ui_elements/expandable_padded_card.dart';
import 'add_to_saved_connections_button.dart';

class FromToWidget extends StatelessWidget {
  final Connection connection;
  const FromToWidget({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return ExpandablePaddedCard(
      alwaysVisibleChild: FromToText(
        from: connection.from?.station,
        to: connection.to?.station,
      ),
      hideableChildren: [
        Text(
            "${ConnectionsList.connectionDateString(connection)}, ${TravelDurationRow.durationString(connection.duration)}"),
        TimeAndStopsRow(connection: connection),
        if (SavedConnections.of(context) != null) ...[
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AddToSavedConnectionsButton(connection: connection),
          ),
        ]
      ],
    );

    //return PaddedCard(
    //  child: ExpansionTile(
    //    title: FromToText(
    //      from: connection.from?.station,
    //      to: connection.to?.station,
    //      textStyle: Theme.of(context).textTheme.bodyMedium,
    //    ),
    //    initiallyExpanded: true,
    //    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    //    tilePadding: EdgeInsets.zero,
    //    //childrenPadding: EdgeInsets.all(10),
    //    textColor: Theme.of(context).textTheme.bodyMedium?.color,
    //    children: [
    //      Text(
    //          "${ConnectionsList.connectionDateString(connection)}, ${TravelDurationRow.durationString(connection.duration)}"),
    //      TimeAndStopsRow(connection: connection)
    //    ],
    //  ),
    //);

    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       FromToText(
    //           from: connection.from?.station, to: connection.to?.station),
    //       Text(
    //           "${ConnectionsList.connectionDateString(connection)}, ${TravelDurationRow.durationString(connection.duration)}"),
    //       TimeAndStopsRow(connection: connection)
    //     ],
    //   ),
    // );
  }

  void Function()? onPressed(BuildContext context) {
    SavedConnections? savedConnections = SavedConnections.of(context);

    if (savedConnections == null ||
        savedConnections.list.stringContains(connection)) {
      return null;
    }
    List<Connection> savedConnectionsList = savedConnections.list;
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    return () {
      if (savedConnectionsList.stringContains(connection)) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Verbindung bereits gemerkt')),
        );
      } else {
        savedConnections.add(connection);
        messenger.showSnackBar(
          const SnackBar(
              content: Text('Verbindung zu gemerkten Reisen hinzugefügt')),
        );
      }
    };
  }
}
