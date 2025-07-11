import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';

class CustomPage extends StatelessWidget with WidgetWithTitle {
  @override
  final String title;

  @override
  final IconData? icon;

  final Widget body;
  final TabBar? tabBar;

  const CustomPage(
      {super.key,
      required this.title,
      required this.body,
      this.tabBar,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          bottom: tabBar,
        ),
        body: body);
  }
}
