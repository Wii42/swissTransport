import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import '../from_to_text.dart';

class FromToInfo extends StatelessWidget {
  final Connections connections;

  const FromToInfo({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: FromToText(from: connections.from, to: connections.to),
    );
  }
}
