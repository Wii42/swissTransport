import 'package:flutter/material.dart';
import 'package:sbb/connection_page/connection_info.dart';
import 'package:sbb/connection_page/from_to_widget.dart';

import 'package:sbb/ui/custom_page.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class ConnectionPage extends StatelessWidget {
  final Connection connection;

  const ConnectionPage({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
        title: 'Verbindung',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FromToWidget(connection: connection),
            Expanded(
                child: ConnectionInfo(
              connection: connection,
            ))
          ],
        ));
  }

  static Widget inRoute([dynamic connection]) =>
      ConnectionPage(connection: connection);
}
