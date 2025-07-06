import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sbb/helper/go_subroute_extension.dart';

import '../generic_ui_elements/expandable_padded_form_card.dart';
import '../transport_api/transport_objects/connections.dart';
import '../ui/connections_form_skeleton.dart';
import '../ui/from_to_text.dart';

class TopWidget extends ConnectionsFormSkeleton {
  final Connections connections;
  final bool initiallyExpanded;

  const TopWidget(
      {super.key, required this.connections, this.initiallyExpanded = false});

  @override
  String? get initialFrom => connections.from?.name;
  @override
  String? get initialTo => connections.to?.name;

  @override
  ConnectionsFormSkeletonState createState() {
    return TopWidgetState();
  }
}

class TopWidgetState extends ConnectionsFormSkeletonState<TopWidget> {
  @override
  Widget build(BuildContext context) {
    return ExpandablePaddedFormCard(
      alwaysVisibleChild:
          FromToText(from: widget.connections.from, to: widget.connections.to),
      formKey: formKey,
      hideableChildren: [
        alwaysVisibleFields(),
        ...hideableOptions(context),
        Row(children: [sendButton(), const Spacer()])
      ],
      initiallyExpanded: widget.initiallyExpanded,
    );
  }

  @override
  void pushRoute(
      {required String routeName, required Future<Connections> connections}) {
    context.pop();
    context.pushSubRoute(routeName, extra: connections);
  }
}
