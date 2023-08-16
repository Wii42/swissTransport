import 'package:flutter/material.dart';

import '../generic_ui_elements/padded_card.dart';
import '../transport_api/transport_objects/section.dart';

class InfoWidget extends StatelessWidget {
  final Section section;

  const InfoWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              if (section.transportVehicle != null)
                Icon(section.transportVehicle?.icon, size: 14),
              Text(
                section.transportName ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(section.journey?.name ?? ''),
              Text(section.journey?.operator ?? '')
            ],
          ),
          Text(
            'Richtung ${section.direction}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}