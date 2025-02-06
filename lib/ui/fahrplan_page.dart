import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/ui/departure_data_table.dart';

import 'connections_form.dart';

class FahrplanPage extends StatefulWidget with WidgetWithTitle {
  @override
  final String title = "Fahrplan";

  @override
  final IconData? icon = null;

  const FahrplanPage({super.key});

  @override
  State<FahrplanPage> createState() => _FahrplanPageState();
}

class _FahrplanPageState extends State<FahrplanPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const [
        ConnectionsForm(),
        DepartureDataTable(station: "Bern", limit: 7),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
