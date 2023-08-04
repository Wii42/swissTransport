import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class TransportApiRequest {
  List<String> get parametersList;

  String parametersAsString() {
    return parametersList.join('&');
  }

  String get apiUrl;

  Future<http.Response> callApi() async {
    String parameters = parametersAsString();

    Uri url = Uri.parse("$apiUrl?$parameters");

    http.Response response = await http.get(url);
    print("${response.statusCode} ${response.request}");
    return response;
  }

  Map<String, dynamic> extractJson(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
          "${response.request} failed with statuscode ${response.statusCode}");
    }
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<Map<String, dynamic>> getJsonResponse() async {
    http.Response apiResponse = await callApi();
    return extractJson(apiResponse);
  }
}
