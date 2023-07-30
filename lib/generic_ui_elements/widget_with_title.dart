import 'package:flutter/material.dart';

abstract class WidgetWithTitle extends StatelessWidget {
  const WidgetWithTitle({super.key});

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
}
