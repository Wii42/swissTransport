import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

class FromToText extends StatelessWidget {
  final Location? from;
  final Location? to;
  final bool multipleLines;
  final TextStyle? textStyle;

  const FromToText(
      {super.key,
      required this.from,
      required this.to,
      this.multipleLines = true,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: from?.name ?? "?",
          ),
          const TextSpan(text: ' '),
          WidgetSpan(
            child: Icon(
              Icons.arrow_right_alt,
              size: style(context)?.fontSize,
              color: style(context)?.color,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(text: to?.name ?? "?"),
        ],
      ),
      softWrap: multipleLines,
      overflow: TextOverflow.fade,
      style: boldStyle(context),
    );

    // return Wrap(
    //   alignment: WrapAlignment.start,
    //   crossAxisAlignment: WrapCrossAlignment.center,
    //   spacing: 5,
    //   children: [
    //     Text(
    //       from?.name ?? "?",
    //       style: const TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //     const Icon(Icons.arrow_right_alt),
    //     Text(
    //       to?.name ?? "?",
    //       style: const TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //   ],
    // );
  }

  TextStyle? style(BuildContext context) {
    return textStyle ?? Theme.of(context).textTheme.bodyMedium;
  }

  TextStyle boldStyle(BuildContext context) {
    TextStyle? textStyle = style(context);
    TextStyle bold = const TextStyle(fontWeight: FontWeight.bold);
    if (textStyle == null) {
      return bold;
    }
    return textStyle.merge(bold);
  }
}
