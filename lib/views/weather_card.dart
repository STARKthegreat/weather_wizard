import 'package:flutter/material.dart';
import 'package:weather_wizard/models/weather_model.dart';

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
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(weatherName),
        Text(locationName),
      ],
    );
  }
}
