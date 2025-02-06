import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/expandable_padded_form_card.dart';
import 'package:sbb/helper/go_subroute_extension.dart';
import '../transport_api/transport_objects/connections.dart';
import 'connections_form_skeleton.dart';

class ConnectionsForm extends ConnectionsFormSkeleton {
  const ConnectionsForm({super.key});

  @override
  ConnectionsFormState createState() {
    return ConnectionsFormState();
  }

  @override
  final DateTime? initialDate = null;
}

class ConnectionsFormState
    extends ConnectionsFormSkeletonState<ConnectionsForm> {
  @override
  Widget build(BuildContext context) {
    return ExpandablePaddedFormCard(
      alwaysVisibleChild: alwaysVisibleFields(),
      formKey: formKey,
      hideableChildren: hideableOptions(context),
      suffixWidget: sendButton(),
    );
  }

  @override
  void pushRoute(
      {required String routeName, required Future<Connections> connections}) {
    context.pushSubRoute(routeName, extra: connections);
  }
}
