import 'package:flutter/material.dart';
import 'package:sbb/widget_with_title.dart';

import 'connections_form.dart';
import 'departure_table.dart';

class FahrplanPage extends WidgetWithTitle {
  @override
  final String title = "Fahrplan";

  @override
  final IconData? icon = null;

  const FahrplanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [ConnectionsForm(), DepartureTable(station: "Wengwald")],
    );
  }
}
