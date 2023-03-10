import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_wizard/res/const/app_res_string.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.weatherName,
    required this.locationName,
    required this.weatherDescription,
  });
  final String weatherName;
  final String locationName;
  final String weatherDescription;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          weatherName == "Clouds"
              ? Lottie.asset(
                  AppAssets.cloudyAnimation,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )
              : weatherName.contains('Sun')
                  ? Lottie.asset(
                      AppAssets.sunnyAnimation,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : weatherName.contains('wind')
                      ? LottieBuilder.asset(AppAssets.windy)
                      : Container(),
          Text(locationName),
          Text(weatherName),
          Text(weatherDescription),
        ],
      ),
    );
  }
}
