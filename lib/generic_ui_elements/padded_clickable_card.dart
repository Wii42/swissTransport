import 'package:flutter/material.dart';

class PaddedClickableCard extends StatelessWidget {
  final Widget child;
  final double inset;
  final void Function()? onTap;

  const PaddedClickableCard(
      {super.key, required this.child, this.inset = 10, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(inset),
          child: child,
        ),
      ),
    );
  }
}
