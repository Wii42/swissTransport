import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbb/generic_ui_elements/expandable_padded_form_card.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import '../generic_ui_elements/two_options_toggle_form_field.dart';

class ConnectionsForm extends StatefulWidget {
  const ConnectionsForm({super.key});

  @override
  ConnectionsFormState createState() {
    return ConnectionsFormState();
  }
}

class ConnectionsFormState extends State<ConnectionsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController =
      TextEditingController(text: formatDate(DateTime.now()));
  TextEditingController timeController =
      TextEditingController(text: formatTime(TimeOfDay.now()));

  String? from;
  String? to;
  String? via;

  DateTime? date;
  TimeOfDay? time;
  bool? isArrivalTime, direct, sleeper, couchette, bike;

  @override
  Widget build(BuildContext context) {
    return ExpandablePaddedFormCard(
      alwaysVisibleChild: alwaysVisibleFields(),
      formKey: _formKey,
      hideableChildren: hideableOptions(context),
      suffixWidget: sendButton(),
    );
  }

  Padding sendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: _sendRequest,
        child: const Text('Verbindungen anzeigen'),
      ),
    );
  }

  Column alwaysVisibleFields() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Von",
            icon: Icon(Icons.start),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bitte eine Station eingeben';
            }
            return null;
          },
          onSaved: (input) {
            from = input;
          },
        ),
        TextFormField(
          decoration: const InputDecoration(
              labelText: "Nach", icon: Icon(Icons.arrow_forward)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Bitte eine Station eingeben';
            }
            return null;
          },
          onSaved: (input) {
            to = input;
          },
        ),
      ],
    );
  }

  List<Widget> hideableOptions(BuildContext context) {
    return [
      TextFormField(
        decoration: const InputDecoration(
            labelText: "Via", icon: Icon(Icons.airline_stops)),
        onSaved: (input) {
          via = input;
        },
      ),
      TextFormField(
        controller: dateController,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_month), labelText: "Datum wählen"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(), //get today's date
              firstDate: DateTime.now().subtract(const Duration(days: 200)),
              lastDate: DateTime.now().add(const Duration(days: 120)));
          setState(() {
            date = pickedDate;
            dateController.text = formatDate(date ?? DateTime.now());
          });
        },
      ),
      TextFormField(
        controller: timeController,
        decoration: const InputDecoration(
            icon: Icon(Icons.access_time), labelText: "Uhrzeit wählen"),
        readOnly: true,
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: time ?? TimeOfDay.now(),
          );
          setState(() {
            time = pickedTime;
            timeController.text = formatTime(time ?? TimeOfDay.now());
          });
        },
      ),
      TwoOptionsToggleFormField(
        firstOption: 'Ab',
        secondOption: 'An',
        icon: const Icon(Icons.multiple_stop),
        onSaved: (input) {
          isArrivalTime = input;
        },
      )
    ];
  }

  void _sendRequest() {
    if (!_isInputValid()) {
      return;
    }
    _formKey.currentState!.save();
    TransportApi api = const TransportApi();
    Future<Connections> connections = api.connections(
        from: from!,
        to: to!,
        via: (via != null && via!.isNotEmpty) ? [via!] : null,
        date: date,
        time: time,
        isArrivalTime: isArrivalTime,
        direct: direct,
        sleeper: sleeper,
        couchette: couchette,
        bike: bike,
        limit: 10);
    Routes.connections.push(context, params: connections);
  }

  static String formatTime(TimeOfDay time) {
    String timeString = DateFormat("HH:mm").format(
      DateTime(0, 0, 0, time.hour, time.minute),
    );
    if (time == TimeOfDay.now()) {
      timeString += ' ( Jetzt )';
    }
    return timeString;
  }

  static String formatDate(DateTime date) {
    String dateString = DateFormat("dd.MM.yyyy").format(date);
    if (isToday(date)) {
      dateString += ' ( Heute )';
    }
    return dateString;
  }

  static bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day);
  }

  bool _isInputValid() => _formKey.currentState!.validate();
}
