import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/padded_card.dart';
import 'package:sbb/generic_ui_elements/widget_with_title.dart';
import 'package:sbb/journey_page/pass_list.dart';

import '../transport_api/transport_objects/journey.dart';
import '../transport_api/transport_objects/section.dart';
import '../ui/custom_page.dart';
import 'info_widget.dart';

class JourneyPage extends WidgetWithTitle {
  @override
  final String title = 'Fahrtinfo';
  @override
  final IconData icon = Icons.airline_stops;

  final Section section;

  const JourneyPage(this.section, {super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: title,
      icon: icon,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoWidget(section: section),
          Expanded(
              child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [PaddedCard(child: PassList(section: section))],
          )),
        ],
      ),
    );
  }

  factory JourneyPage.inRoute([dynamic section]) {
    return JourneyPage(section);
  }
}
