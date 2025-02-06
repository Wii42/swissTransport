import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

abstract class TransportApiRequest {
  Map<String, dynamic> get queryParameters;

  final Uri baseUrl = Uri.https("transport.opendata.ch", "v1");
  String get apiEndpoint;

  Future<http.Response> callApi() async {
    Uri url = Uri.https(baseUrl.authority,
        [...baseUrl.pathSegments, apiEndpoint].join('/'), queryParameters);

    http.Response response = await http.get(url);
    log("${response.statusCode} ${response.request}");
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
