import 'package:flutter/material.dart';

import '../transport_api/transport_objects/connection.dart';

class TransportTypeAndDurationRow extends StatelessWidget {
  final Connection connection;

  const TransportTypeAndDurationRow({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: [
        if (connection.transportVehicle != null)
          Icon(connection.transportVehicle?.icon, size: 14),
        Text(
          connection.transportProduct ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Richtung ${connection.direction}"),
      ],
    );
  }
}
