import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sbb/generic_ui_elements/expandable_padded_form_card.dart';
import 'package:sbb/ui/routes.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';

class ConnectionsForm extends StatefulWidget {
  const ConnectionsForm({super.key});

  @override
  ConnectionsFormState createState() {
    return ConnectionsFormState();
  }
}

class ConnectionsFormState extends State<ConnectionsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController(text: 'heute');
  TextEditingController timeController = TextEditingController(
    text: DateFormat("hh:mm").format(
      DateTime(0, 0, 0, TimeOfDay.now().hour, TimeOfDay.now().minute).toLocal(),
    ),
  );

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
            icon: Icon(Icons.calendar_today), labelText: "Datum wählen"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: date ?? DateTime.now(), //get today's date
              firstDate: DateTime.now().subtract(const Duration(days: 200)),
              lastDate: DateTime.now().add(const Duration(days: 120)));
          setState(() {
            dateController.text = pickedDate.toString();
            date = pickedDate;
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
            timeController.text = pickedTime != null
                ? DateFormat("hh:mm").format(
                    DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute))
                : '-';
            time = pickedTime;
          });
        },
      ),
      CheckboxFormField(
        title: const Text('Zeit und datum sind Ankunftszeit'),
        onSaved: (input) {
          isArrivalTime = input;
        },
      ),
    ];
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
    //context.push(Routes.connections.string, extra: connections);
    Routes.connections.push(context, params: connections);
    //Navigator.of(context)
    //  .pushNamed(Routes.connections.string, arguments: connections);

    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Processing Data')),
    //);
  }

  bool _isInputValid() => _formKey.currentState!.validate();
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Checkbox(
                    value: state.value,
                    onChanged: state.didChange,
                  ),
                  if (title != null) title
                ],
              );
            });
}
