import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiUser<T extends Object> extends StatelessWidget {
  final Future<T> apiCall;
  final Widget Function(BuildContext context, T data) displayResponse;
  final Widget progressIndicator;
  final Widget? Function(Object error)? onError;

  const ApiUser(
      {super.key,
      required this.apiCall,
      required this.displayResponse,
      this.progressIndicator = const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
      this.onError});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: apiCall,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          T response = snapshot.data as T;
          return displayResponse(context, response);
        } else if (snapshot.hasError) {
          return errorHandling(snapshot.error!);
        } else {
          return Center(child: progressIndicator);
        }
      },
    );
  }

  Widget errorHandling(Object error) {
    Widget? errorMessage;
    if (onError != null) {
      errorMessage = onError!(error);
    }
    errorMessage = errorMessage ?? serverNotFound(error);
    return errorMessage ?? Text(error.toString());
  }

  static Widget? serverNotFound(Object error) {
    if (error is ClientException && error is SocketException) {
      return Center(
        child: Text(
            'Verbingung zum Server konnte nicht aufgebaut werden.\n\nDetails:\n${error.message}, URL: ${error.uri}'),
      );
    }
    return null; //Text(error.runtimeType.toString());
  }
}
