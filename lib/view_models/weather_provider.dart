import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_enums.dart';
import 'package:weather_wizard/network/network_helper.dart';
import 'package:weather_wizard/network/network_service.dart';
import 'package:weather_wizard/network/query_params.dart';
import 'package:weather_wizard/res/const/app_url.dart';
import 'package:weather_wizard/view_models/location_provider.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel weatherModel = WeatherModel();
  bool isLoading = true;
  bool get isLoaded => isLoading;
  Future<WeatherModel?> getWeather() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      uri: const AppUrl().baseUrl,
      queryParam: QueryParams.apiQp(
        apiKey: const AppUrl().appid,
        lat: LocationProvider().location.latitude.toString(),
        lon: LocationProvider().location.longitude.toString(),
      ),
    );

    log(response!.statusCode.toString());
    weatherModel = weatherModelFromJson(response.body);
    if (response.statusCode == 200) {
      isLoading = false;
      return await NetworkHelper.filterResponse(
        callBack: (json) {
          notifyListeners();
          return weatherModel;
        },
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          log('Error Type-$errorType - Message: $msg');
        },
      );
    }

    return null;
  }
}
