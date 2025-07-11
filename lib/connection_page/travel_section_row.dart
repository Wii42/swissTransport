import 'package:flutter/material.dart';
import 'package:sbb/connections_page/stops_indicator.dart';
import 'package:sbb/connections_page/time_and_stops_row.dart';
import 'package:sbb/helper/go_subroute_extension.dart';

import '../generic_ui_elements/padded_clickable_card.dart';
import '../transport_api/transport_objects/section.dart';
import '../transport_api/transport_objects/stop.dart';
import '../ui/routes.dart';

class TravelSectionRow extends StatelessWidget {
  final Section section;
  final bool isStartOfConnection;
  final bool isEndOfConnection;
  const TravelSectionRow(
      {super.key,
      required this.section,
      this.isStartOfConnection = false,
      this.isEndOfConnection = false});

  @override
  Widget build(BuildContext context) {
    if (section.hasWalk) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: TimeAndStopsRow.walkingIndicator(section,
              suffix: const Text(' Fussweg')));
    }
    return PaddedClickableCard(
      onTap: () => context.pushSubRoute(Routes.journey.string, extra: section),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            times(),
            verticalStopsIndicator(context),
            stationNames(context),
            const Spacer(),
            tracks(),
          ],
        ),
      ),
    );
  }

  Stop? get start => section.departure;
  Stop? get end => section.arrival;

  Widget times() {
    return SizedBox(
      width: 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                start?.departureTimeString ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (start != null && start!.hasDelay)
                TimeAndStopsRow.delayText(start!),
            ],
          ),
          Column(
            children: [
              if (end != null && end!.hasDelay) TimeAndStopsRow.delayText(end!),
              Text(end?.arrivalTimeString ?? ""),
            ],
          ),
        ],
      ),
    );
  }

  Widget verticalStopsIndicator(BuildContext context) {
    return SizedBox(
      width: 25,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (isStartOfConnection)
                ? StopsIndicator.endStopIcon
                : StopsIndicator.inBetweenStopIcon,
            Expanded(
              child: StopsIndicator.verticalLine(context),
            ),
            (isEndOfConnection)
                ? StopsIndicator.endStopIcon
                : StopsIndicator.inBetweenStopIcon,
          ],
        ),
      ),
    );
  }

  Column stationNames(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(start?.station?.name ?? '?',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: additionalInfos(context)),
        Text(end?.station?.name ?? '?'),
      ],
    );
  }

  Widget additionalInfos(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 2,
          children: [
            if (section.transportVehicle != null)
              Icon(section.transportVehicle?.icon, size: 11),
            Text(section.transportName ?? '',
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
        Text(
          'Richtung ${section.direction}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Column tracks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (start?.platform != null && start!.platform!.isNotEmpty)
              ? "Gl. ${start?.platform}"
              : "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text((end?.platform != null && end!.platform!.isNotEmpty)
            ? "Gl. ${end?.platform}"
            : ""),
      ],
    );
  }
}
