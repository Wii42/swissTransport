import 'package:flutter/material.dart';
import 'package:sbb/connections_page/stops_indicator.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';

import '../transport_api/transport_objects/section.dart';
import '../transport_api/transport_objects/stop.dart';

class TravelSectionTable extends StatelessWidget {
  final Section section;
  const TravelSectionTable({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return PaddedCard(
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [departure(), infos(), arrival()],
      ),
    );
  }

  TableRow departure() {
    Stop? start = section.departure;
    return TableRow(children: [
      Text(
        start?.departureTimeString ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      StopsIndicator.endStopIcon,
      Text(start?.station?.name ?? '?',
          style: const TextStyle(fontWeight: FontWeight.bold)),
      Text("Gl. ${start?.platform}",
          style: const TextStyle(fontWeight: FontWeight.bold))
    ]);
  }

  TableRow arrival() {
    Stop? end = section.arrival;
    return TableRow(children: [
      Text(end?.arrivalTimeString ?? ""),
      StopsIndicator.endStopIcon,
      Text(end?.station?.name ?? '?'),
      Text("Gl. ${end?.platform}")
    ]);
  }

  TableRow infos() {
    return TableRow(
      children: [
        const SizedBox(),
        const Text(
          '|',
          textAlign: TextAlign.center,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(section.journey?.category ?? ''),
            const Text('Richtung'),
          ],
        ),
        const Text("Kapazität")
      ],
    );
  }
}
