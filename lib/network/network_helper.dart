// concat headers
import 'dart:convert';
import 'dart:developer';

import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_enums.dart';
import 'package:weather_wizard/network/network_typedef.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  static String concatUrlQP(String url, Map<String, String>? queryParam) {
    if (url.isEmpty) return url;
    if (queryParam == null || queryParam.isEmpty) return url;
    final StringBuffer stringBuffer = StringBuffer("$url?");
    queryParam.forEach((key, value) {
      if (value.trim() == '') return;
      if (value.contains(' ')) throw Exception('Invalid Input Exception');
      stringBuffer.write('$key=$value&');
    });
    final result = stringBuffer.toString();
    return result.substring(0, result.length - 1);
  }

  static bool _isValidResponse(json) {
    return json != null;
  }

  static R filterResponse<R>(
      {required NetworkCallBack callBack,
      required http.Response? response,
      required NetworkOnFailureCallBackWithMessage onFailureCallBackWithMessage,
      CallBackParameterName parameterName = CallBackParameterName.all}) {
    try {
      if (response == null || response.body.isEmpty) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.responseEmpty, 'Response is empty');
      }

      WeatherModel output = weatherModelFromJson(response.body);

      if (response.statusCode == 200) {
        if (_isValidResponse(output)) {
          return callBack(parameterName.getJson(output));
        }
      } else if (response.statusCode == 1708) {
        return onFailureCallBackWithMessage(
            NetworkResponseErrorType.socket, 'socket Error');
      }
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.didNotSucceed, 'Unknown');
    } catch (e) {
      var output = weatherModelFromJson(response!.body);
      log(output.name!);
      return onFailureCallBackWithMessage(
          NetworkResponseErrorType.exception, 'Exception: $e');
    }
  }
}
