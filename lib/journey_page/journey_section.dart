import 'package:flutter/material.dart';

import '../connections_page/stops_indicator.dart';
import '../connections_page/time_and_stops_row.dart';
import '../transport_api/transport_objects/stop.dart';

class JourneySection extends StatelessWidget {
  final Stop stop;
  final Stop? nextStop;

  final bool isStartOrEndOfSection;
  final bool isFinalDestination;
  final bool isHeadedToFinalDestination;

  const JourneySection({
    super.key,
    required this.stop,
    required this.nextStop,
    this.isStartOrEndOfSection = false,
    this.isFinalDestination = false,
    this.isHeadedToFinalDestination = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: ConstrainedBox(
      constraints: BoxConstraints(minHeight: !isFinalDestination ? 50 : 0),
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
    ));
  }

  Widget times() {
    return SizedBox(
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: timesSwitch(),
        ));
  }

  List<Widget> timesSwitch() {
    if (!isFinalDestination) {
      return [
        Column(
          children: [
            Text(
              stop.departureTimeString ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (stop.hasDelay) TimeAndStopsRow.delayText(stop),
          ],
        ),
        if (stop.isRealStop && (nextStop != null && nextStop!.isRealStop))
          const SizedBox(
            height: 20,
          ),
        if (nextStop != null && !isHeadedToFinalDestination)
          Column(
            children: [
              if (nextStop!.hasDelay) TimeAndStopsRow.delayText(nextStop!),
              Text(nextStop?.arrivalTimeString ?? ""),
            ],
          ),
      ];
    } else {
      return [
        Column(
          children: [
            if (stop.hasDelay) TimeAndStopsRow.delayText(stop),
            Text(stop.arrivalTimeString ?? ""),
          ],
        ),
      ];
    }
  }

  Widget verticalStopsIndicator(BuildContext context) {
    return SizedBox(
      width: 25,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: (stop.isRealStop)
            ? [
                SizedBox(
                  height: 5,
                  child: !isStartOrEndOfSection
                      ? StopsIndicator.verticalLine(context, indent: 0)
                      : null,
                ),
                (isStartOrEndOfSection)
                    ? StopsIndicator.endStopIcon
                    : StopsIndicator.inBetweenStopIcon,
                if (nextStop != null)
                  Expanded(
                    child: StopsIndicator.verticalLine(context, endIndent: 0),
                  ),
              ]
            : [
                Expanded(
                    child: StopsIndicator.verticalLine(context,
                        indent: 0, endIndent: 0)),
              ],
      ),
    );
  }

  Column stationNames(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(stop.station?.name ?? '?',
            style: isStartOrEndOfSection
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null),
        if (!isFinalDestination)
          const SizedBox(
            height: 10,
          )
      ],
    );
  }

  Column tracks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (stop.platform != null && stop.platform!.isNotEmpty)
              ? "Gl. ${stop.platform}"
              : "",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
