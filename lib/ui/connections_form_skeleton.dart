import 'package:flutter/material.dart';
import 'package:sbb/transport_api/helper/date_time_helper.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/ui/routes.dart';

import '../generic_ui_elements/two_options_toggle_form_field.dart';
import '../helper/time_format.dart';
import 'autocomplete_location_form_field.dart';

abstract class ConnectionsFormSkeleton extends StatefulWidget {
  const ConnectionsFormSkeleton({super.key});

  String? get initialFrom => null;

  String? get initialTo => null;

  DateTime? get initialDate => null;

  TimeOfDay? get initialTime => null;

  @override
  ConnectionsFormSkeletonState createState();
}

abstract class ConnectionsFormSkeletonState<T extends ConnectionsFormSkeleton>
    extends State<T> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController fromController =
      TextEditingController(text: widget.initialFrom);
  late TextEditingController toController =
      TextEditingController(text: widget.initialTo);
  late TextEditingController dateController = TextEditingController(
    text: formatDate(widget.initialDate ?? DateTime.now()),
  );
  late TextEditingController timeController = TextEditingController(
    text: formatTime(widget.initialTime ?? TimeOfDay.now()),
  );

  String? from;
  String? to;
  String? via;

  DateTime? date;
  TimeOfDay? time;
  bool? isArrivalTime, direct, sleeper, couchette, bike;

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

  Widget toField(TextEditingController controller, {bool hasIcon = true}) {
    return AutocompleteLocationFormField(
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

  Widget fromField(TextEditingController controller, {bool hasIcon = true}) {
    return AutocompleteLocationFormField(
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

  String? validateStationForm(String? value) {
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
      AutocompleteLocationFormField(
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
    formKey.currentState!.save();
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
    pushRoute(routeName: Routes.connections.string, connections: connections);
    //Navigator.of(context)
    //    .pushNamed(Routes.connections.string, arguments: connections);
    //Routes.connections.push(context, params: connections);
  }

  void pushRoute(
      {required String routeName, required Future<Connections> connections});

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

  bool _isInputValid() => formKey.currentState!.validate();
}
