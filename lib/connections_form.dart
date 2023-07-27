import 'package:flutter/material.dart';
import 'package:sbb/padded_card.dart';
import 'package:sbb/routes.dart';
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
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return PaddedCard(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(labelText: "From"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
              onSaved: (input) {
                from = input;
              },
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(labelText: "To"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
              onSaved: (input) {
                to = input;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: _sendRequest,
                child: const Text('Show connections'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendRequest() {
    if (!_isInputValid()) {
      return;
    }
    _formKey.currentState!.save();
    TransportApi api = const TransportApi();
    Future<Connections> connections = api.connections(from: from!, to: to!, limit: 10);

    Navigator.of(context)
        .pushNamed(Routes.connections.string, arguments: connections);

    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Processing Data')),
    //);
  }

  bool _isInputValid() => _formKey.currentState!.validate();
}
