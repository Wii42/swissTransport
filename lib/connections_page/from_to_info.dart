import 'package:flutter/material.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

class FromToInfo extends StatelessWidget {
  final Connections connections;

  const FromToInfo({super.key, required this.connections});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Wrap(
        alignment: WrapAlignment.start,
       crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Text(connections.from?.name ?? "?",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const Icon(Icons.arrow_right_alt),
          Text(connections.to?.name ?? "?",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
