import 'package:flutter/material.dart';

import '../generic_ui_elements/fillable_spacer.dart';
import '../transport_api/transport_objects/connection.dart';
import '../transport_api/transport_objects/section.dart';

class StopsIndicator extends StatelessWidget {
  static const Widget endStopIcon = Icon(Icons.circle, size: 9);
  static const Widget inBetweenStopIcon = Icon(Icons.circle_outlined, size: 8);

  final Connection connection;

  const StopsIndicator({super.key, required this.connection});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: indicatorElements(context),
    );
  }

  List<Widget> indicatorElements(BuildContext context) {
    List<Widget> list = [endStopIcon];
    if (connection.sections != null) {
      for (int i = 0; i < connection.sections!.length; i++) {
        Section section = connection.sections![i];
        if (!section.hasWalk) {
          list.add(
            lineSegment(
              context,
              relativeLength: calculateLength(section),
            ),
          );
          list.add(i == connection.sections!.length - 1
              ? endStopIcon
              : inBetweenStopIcon);
        }
      }
    } else {
      list.add(lineSegment(context));
      list.add(endStopIcon);
    }

    return list;
  }

  int calculateLength(Section section) {
    DateTime? start = section.departure?.departure;
    DateTime? end = section.arrival?.arrival;
    if (start == null || end == null) {
      return 1;
    }
    Duration duration = end.difference(start).abs();
    return duration.inMinutes;
  }

  Widget lineSegment(BuildContext context, {int relativeLength = 1}) {
    return FillableSpacer(flex: relativeLength, child: line(context));
  }

  static Widget line(BuildContext context) {
    return Divider(
        thickness: 1,
        indent: 2,
        endIndent: 1.5,
        color: Theme.of(context).textTheme.bodyMedium?.color);
  }

  static Widget verticalLine(BuildContext context) {
    return VerticalDivider(
        thickness: 1,
        indent: 2,
        endIndent: 1.5,
        color: Theme.of(context).textTheme.bodyMedium?.color);
  }
}
