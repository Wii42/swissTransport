import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiUser<T extends Object> extends StatefulWidget {
  final Future<T> apiCall;
  final Widget Function(T data) displayResponse;
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
  State<ApiUser<T>> createState() => _ApiUserState<T>();

  static Widget? serverNotFound(Object error) {
    if (error is ClientException && error is SocketException) {
      return Center(
          child:
          Text('Verbingung zum Server konnte nicht aufgebaut werden.\n\nDetails:\n${error.message}, URL: ${error.uri}'),

      );
    }
    return null; //Text(error.runtimeType.toString());
  }
}

class _ApiUserState<T extends Object> extends State<ApiUser<T>> {
  T? response;
  @override
  Widget build(BuildContext context) {
    if (response == null) {
      return FutureBuilder<T>(
        future: widget.apiCall,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasData) {
            response = snapshot.data as T;
            return widget.displayResponse(response!);
          } else if (snapshot.hasError) {
            return errorHandling(snapshot.error!);
          } else {
            return Center(child: widget.progressIndicator);
          }
        },
      );
    }
    return widget.displayResponse(response!);
  }

  Widget errorHandling(Object error) {
    Widget? errorMessage;
    if (widget.onError != null) {
      errorMessage = widget.onError!(error);
    }
    errorMessage = errorMessage ?? ApiUser.serverNotFound(error);
    return errorMessage ?? Text(error.toString());
  }
}
