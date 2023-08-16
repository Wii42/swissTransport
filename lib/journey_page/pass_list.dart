import 'package:flutter/material.dart';

import '../transport_api/transport_objects/section.dart';
import '../transport_api/transport_objects/stop.dart';
import 'journey_section.dart';

class PassList extends StatelessWidget {
  final Section section;

  const PassList({super.key, required this.section});
  @override
  Widget build(BuildContext context) {
    if (section.journey?.passList == null) {
      return const Center(
        child: Text('Keine weiteren Infos verfügbar'),
      );
    }
    return Column(children: listElements());
  }

  List<Widget> listElements() {
    List<Widget> list = [];

    List<Stop> passList = section.journey!.passList!;
    for (int i = 0; i < passList.length; i++) {
      Stop stop = passList[i];
      Stop? nextStop = (i + 1 < passList.length) ? passList[i + 1] : null;

      list.add(
        JourneySection(
          stop: stop,
          nextStop: nextStop,
          isStartOrEndOfSection: (i == 0 || (nextStop == null)),
          isFinalDestination: (nextStop == null),
          isHeadedToFinalDestination: (i + 2 >= passList.length)
        )
      );
    }

    return list;
  }
}
