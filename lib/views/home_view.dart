import 'package:flutter/material.dart';
import 'package:weather_wizard/main.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/views/city_stories.dart';
import 'package:weather_wizard/views/weather_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.weatherModel});
  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    return;
                  },
                  icon: const Icon(Icons.menu),
                ),
                TextField(
                  onChanged: (value) => {},
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: 'Search city',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                      gapPadding: 8,
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const CityStories(),
                ),
              ],
            ),
            RefreshIndicator(
              onRefresh: () => Home.getWeather(),
              child: Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) => WeatherCard(
                    weatherDescription:
                        weatherModel.weather![index].description!,
                    weatherName: weatherModel.weather![index].main!,
                    locationName: weatherModel.name!,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
