import 'package:flutter/material.dart';

class ExpandablePaddedFormCard extends StatelessWidget {
  final Widget alwaysVisibleChild;
  final List<Widget> hideableChildren;
  final double inset;
  final bool initiallyExpanded;
  final Key? formKey;
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  const ExpandablePaddedFormCard(
      {super.key,
      this.formKey,
      required this.alwaysVisibleChild,
      this.hideableChildren = const [],
      this.inset = 10,
      this.initiallyExpanded = false,
      this.prefixWidget,
      this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (prefixWidget != null) prefixWidget!,
            ExpansionTile(
              title: alwaysVisibleChild,
              initiallyExpanded: initiallyExpanded,
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              tilePadding: EdgeInsets.symmetric(horizontal: inset),
              childrenPadding: EdgeInsets.fromLTRB(
                  inset, 0, inset, (suffixWidget == null) ? inset : 0),
              children: hideableChildren,
            ),
            if (suffixWidget != null)
              Padding(
                padding: EdgeInsets.fromLTRB(inset, 0, inset, inset),
                child: suffixWidget!,
              ),
          ],
        ),
      ),
    );
  }
}
