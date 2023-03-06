import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_wizard/network/network_helper.dart';

enum RequestType { get, put, post, delete }

class NetworkService {
  const NetworkService._();
  static Map<String, String> _getHeaders() => {
        'Content-Type': 'application/json',
      };

  static Future<http.Response>? _createRequest({
    required RequestType requestType,
    required Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    if (requestType == RequestType.get) {
      return http.get(uri, headers: headers);
    } else if (requestType == RequestType.post) {
      return http.post(uri, headers: headers, body: body);
    } else if (requestType == RequestType.delete) {
      return http.delete(uri, headers: headers, body: body);
    } else if (requestType == RequestType.put) {
      return http.put(uri, headers: headers, body: body);
    }
    return null;
  }

  static Future<http.Response?>? sendRequest({
    required RequestType requestType,
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? queryParam,
  }) async {
    try {
      final _header = _getHeaders();
      final _url = NetworkHelper.concatUrlQP(url, queryParam);

      final response = await _createRequest(
        requestType: requestType,
        uri: Uri.parse(_url),
        headers: _header,
        body: body,
      );

      return response;
    } catch (e) {
      debugPrint('Error - $e');
      return null;
    }
  }
}
