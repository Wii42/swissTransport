import 'package:flutter/material.dart';

import '../transport_api/transport_objects/connection.dart';

class TransportTypeAndDurationRow extends StatelessWidget {
  final Connection connection;

  const TransportTypeAndDurationRow({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        Text(
          connection.transportProduct ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Richtung ${connection.direction}"),
      ],
    );
  }
}
