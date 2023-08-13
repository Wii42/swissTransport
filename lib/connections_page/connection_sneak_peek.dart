import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/connection.dart';

import '../ui/connection_representation.dart';
import '../generic_ui_elements/padded_clickable_card.dart';
import '../ui/routes.dart';

class ConnectionSneakPeek extends StatelessWidget {
  final Connection connection;
  const ConnectionSneakPeek({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    return PaddedClickableCard(
      onTap: () => Navigator.of(context)
          .pushNamed(Routes.connection.string, arguments: connection),
      //Routes.connection.push(context, params: connection),
      child: ConnectionRepresentation(connection: connection),
    );
  }
}
