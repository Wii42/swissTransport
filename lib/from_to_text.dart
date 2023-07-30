import 'package:flutter/material.dart';
import 'package:sbb/transport_api/transport_objects/location.dart';

class FromToText extends StatelessWidget {
  const FromToText({
    super.key,
    required this.from,
    required this.to,
  });

  final Location? from;
  final Location? to;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: [
        Text(from?.name ?? "?",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const Icon(Icons.arrow_right_alt),
        Text(to?.name ?? "?",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}