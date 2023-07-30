import 'package:flutter/material.dart';

class FillableSpacer extends Spacer {
  final Widget? child;

  const FillableSpacer({super.key, super.flex, this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: SizedBox.shrink(child: child),
    );
  }
}
