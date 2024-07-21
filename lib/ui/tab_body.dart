import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

class TabBody extends StatelessWidget with WidgetWithTitle {
  final Widget body;

  @override
  final String title;

  @override
  final IconData? icon;

  const TabBody({
    super.key,
    required this.title,
    required this.body,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
