import 'package:flutter/material.dart';
import 'package:sbb/connection_page/connection_info.dart';
import 'package:sbb/connection_page/from_to_widget.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

import 'package:sbb/ui/custom_page.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

class ConnectionPage extends StatelessWidget with WidgetWithTitle {
  final Connection connection;

  @override
  final String title = 'Verbindung';
  @override
  final IconData icon = Icons.multiple_stop;

  const ConnectionPage({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
        title: title,
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

  factory ConnectionPage.inRoute([dynamic connection]) =>
      ConnectionPage(connection: connection);
}
