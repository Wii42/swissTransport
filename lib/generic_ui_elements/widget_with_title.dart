import 'package:flutter/material.dart';

mixin WidgetWithTitle on Widget {
  //const WidgetWithTitle({super.key});

  String get title;

  IconData? get icon;

  static List<Tab> titleTabs(List<WidgetWithTitle> widgets) {
    return widgets
        .map<Tab>(
          (WidgetWithTitle tabBody) => Tab(
            text: tabBody.title,
            icon: tabBody.icon != null ? Icon(tabBody.icon) : null,
          ),
        )
        .toList();
  }

  static List<NavigationDestination> destinations(Iterable<WidgetWithTitle> widgets) {
    return widgets
        .map<NavigationDestination>(
          (WidgetWithTitle tabBody) => NavigationDestination(
            label: tabBody.title,
            icon: Icon(tabBody.icon),
          ),
        )
        .toList();
  }
}
