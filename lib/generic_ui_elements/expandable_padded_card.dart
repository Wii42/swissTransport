import 'package:flutter/material.dart';

class ExpandablePaddedCard extends StatelessWidget {
  final Widget alwaysVisibleChild;
  final List<Widget> hideableChildren;
  final double inset;
  final bool initiallyExpanded;

  const ExpandablePaddedCard(
      {super.key,
      required this.alwaysVisibleChild,
      required this.hideableChildren,
      this.inset = 10,
      this.initiallyExpanded = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: alwaysVisibleChild,
        initiallyExpanded: initiallyExpanded,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: EdgeInsets.symmetric(horizontal: inset),
        childrenPadding: EdgeInsets.fromLTRB(inset, 0, inset, inset),
        children: hideableChildren,
      ),
    );
  }
}
