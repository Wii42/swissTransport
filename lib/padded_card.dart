import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  final Widget child;
  final double inset;

  const PaddedCard({super.key, required this.child, this.inset = 10});

  factory PaddedCard.wrap(Widget child, {double? inset}) =>
      PaddedCard(inset: inset!, child: child);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(inset),
        child: child,
      ),
    );
  }
}
