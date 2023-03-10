import 'package:lottie/lottie.dart';
import 'package:weather_wizard/res/const/app_res_string.dart';

enum CurrentWeather {
  cloudy,
  sunny,
  rainny,
}

extension WeatherAnimation on CurrentWeather {
  getWeatherAnimation({required String weatherTitle}) {
    switch (this) {
      case CurrentWeather.cloudy:
        return Lottie.asset(AppAssets.cloudyAnimation);

      case CurrentWeather.rainny:
        return Lottie.asset(AppAssets.rainyAnimation);

      case CurrentWeather.sunny:
        return Lottie.asset(AppAssets.sunnyAnimation);
    }
  }
}
