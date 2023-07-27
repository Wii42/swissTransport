import 'package:flutter/material.dart';
import 'package:sbb/api_user.dart';
import 'package:sbb/transport_api/transport_api.dart';
import 'package:sbb/transport_api/transport_objects/connections.dart';
import 'package:sbb/widget_with_title.dart';

import 'departure_table.dart';

class FahrplanPage extends WidgetWithTitle {
  @override
  final String title = "Fahrplan";

  @override
  final IconData? icon = null;

  const FahrplanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [MyCustomForm(), DepartureTable(station: "Wengwald")],
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      TransportApi api =  const TransportApi();
                      //Future<Connections> connections = api.connections(from: from!, to: to!);

                      //Navigator.of(context).push(
                       // MaterialPageRoute(
                       //   builder: (context) => ApiUser<Connections>(apiCall: connections,displayResponse: (connections) => Text(connections.toString()),),
                       // ),
                      //);

                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Show connections'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
