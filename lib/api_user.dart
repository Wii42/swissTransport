import 'package:flutter/material.dart';

class ApiUser<T extends Object> extends StatefulWidget {
  final Future<T> Function() apiCall;
  final Widget Function(T data) displayResponse;
  const ApiUser(
      {super.key, required this.apiCall, required this.displayResponse});

  @override
  State<ApiUser<T>> createState() => _ApiUserState<T>();
}

class _ApiUserState<T extends Object> extends State<ApiUser<T>> {
  T? response;
  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return FutureBuilder<T>(
        future: widget.apiCall(),
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData) {
            response = snapshot.data as T;
            return widget.displayResponse(response!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error!.toString());
          } else {
            return const SizedBox(width: 50, height: 50, child: CircularProgressIndicator());
          }
        },
      );
    }
    return widget.displayResponse(response!);
  }
}
