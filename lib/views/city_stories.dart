import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_wizard/res/const/app_res_string.dart';

class CityStories extends StatelessWidget {
  const CityStories({super.key, required this.locationName});
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 8,
            child: Lottie.asset(AppAssets.windy),
          ),
          Text(locationName),
        ],
      ),
    );
  }
}
