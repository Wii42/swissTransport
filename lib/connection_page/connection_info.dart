import 'package:flutter/material.dart';
import 'package:sbb/connection_page/travel_section_row.dart';

import '../transport_api/transport_objects/connection.dart';
import '../transport_api/transport_objects/section.dart';

class ConnectionInfo extends StatelessWidget {
  final Connection connection;

  const ConnectionInfo({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    if (connection.sections == null || connection.sections!.isEmpty) {
      return const Center(
        child: Text("Keine weiteren Infos verfügbar"),
      );
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: travelSectionsList(),
    );
  }

  List<Widget> travelSectionsList() {
    List<Widget> list = [];
    for (int i = 0; i < connection.sections!.length; i++) {
      Section section = connection.sections![i];
      bool isStart = (i == 0);
      bool isEnd = (i == connection.sections!.length - 1);
      list.add(TravelSectionRow(
        section: section,
        isStartOfConnection: isStart,
        isEndOfConnection: isEnd,
      ));
    }
    return list;
  }
}
