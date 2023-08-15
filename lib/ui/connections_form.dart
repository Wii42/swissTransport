import 'package:flutter/material.dart';
import 'package:sbb/generic_ui_elements/expandable_padded_form_card.dart';
import 'package:sbb/helper/date_time_helper.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

import '../generic_ui_elements/two_options_toggle_form_field.dart';
import '../helper/time_format.dart';

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

  Widget alwaysVisibleFields() {
    TextEditingController fromController = TextEditingController();
    TextEditingController toController = TextEditingController();

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  fromField(fromController),
                  toField(toController),
                ],
              ),
            ),
            IconButton(
                onPressed: () => swapTexts(fromController, toController),
                icon: const Icon(Icons.swap_vert))
          ],
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: fromField(fromController, hasIcon: false)),
            IconButton(
                onPressed: () => swapTexts(fromController, toController),
                icon: const Icon(Icons.swap_horiz)),
            Expanded(child: toField(toController, hasIcon: false)),
          ],
        );
      }
    });
  }

  TextFormField toField(TextEditingController controller,
      {bool hasIcon = true}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: "Nach",
          icon: hasIcon ? const Icon(Icons.arrow_forward) : null),
      validator: validateStationForm,
      onSaved: (input) {
        to = input;
      },
    );
  }

  TextFormField fromField(TextEditingController controller,
      {bool hasIcon = true}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "Von",
        icon: hasIcon ? const Icon(Icons.start) : null,
      ),
      validator: validateStationForm,
      onSaved: (input) {
        from = input;
      },
    );
  }

  String? validateStationForm(value) {
    if (value == null || value.isEmpty) {
      return 'Bitte eine Station eingeben';
    }
    return null;
  }

  void swapTexts(TextEditingController a, TextEditingController b) {
    String temp = a.text;
    a.text = b.text;
    b.text = temp;
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
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          return Column(children: [dateField(context), timeField(context)]);
        } else {
          return Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(flex: 3, child: dateField(context)),
              const SizedBox(
                width: 30,
              ),
              Expanded(flex: 2, child: timeField(context))
            ],
          );
        }
      }),
      Align(
        child: TwoOptionsToggleFormField(
          firstOption: 'Ab',
          secondOption: 'An',
          //icon: const Icon(Icons.multiple_stop),
          onSaved: (input) {
            isArrivalTime = input;
          },
        ),
      )
    ];
  }

  TextFormField timeField(BuildContext context) {
    return TextFormField(
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
    );
  }

  TextFormField dateField(BuildContext context) {
    return TextFormField(
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
    );
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
    Navigator.of(context)
        .pushNamed(Routes.connections.string, arguments: connections);
    //Routes.connections.push(context, params: connections);
  }

  static String formatTime(TimeOfDay time) {
    String timeString = TimeFormat.HHmm().format(time);
    if (time == TimeOfDay.now()) {
      timeString += ' ( Jetzt )';
    }
    return timeString;
  }

  static String formatDate(DateTime date) {
    String dateString = DateTimeHelper.dayMonthYear.format(date);
    if (date.isToday()) {
      dateString += ' ( Heute )';
    }
    return dateString;
  }

  bool _isInputValid() => _formKey.currentState!.validate();
}
