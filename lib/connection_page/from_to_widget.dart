import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/connections_page/travel_duration_row.dart';
import 'package:sbb/provider/saved_connections.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import '../generic_ui_elements/expandable_padded_card.dart';
import '../ui/date_badge.dart';
import '../ui/from_to_text.dart';
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
            "${DateBadge.connectionDateString(connection)}, ${TravelDurationRow.durationString(connection.duration)}"),
        TimeAndStopsRow(connection: connection),
        if (context.watch<SavedConnections?>() != null) ...[
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
  }

  void Function()? onPressed(BuildContext context) {
    SavedConnections? savedConnections = context.watch<SavedConnections?>();

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
