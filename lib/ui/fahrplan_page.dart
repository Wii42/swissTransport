import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/ui/departure_data_table.dart';

import 'connections_form.dart';

class FahrplanPage extends StatelessWidget with WidgetWithTitle {
  @override
  final String title = "Fahrplan";

  @override
  final IconData? icon = null;

  const FahrplanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        ConnectionsForm(),
        DepartureDataTable(station: "Bern", limit: 7),
      ],
    );
  }
}
