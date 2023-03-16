import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/view_models/weather_provider.dart';
import 'package:weather_wizard/views/city_stories.dart';
import 'package:weather_wizard/views/weather_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.weather,
    required this.weatherModel,
  });
  final Weather weather;
  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final cityList = List.generate(
      10,
      (index) => CityStories(locationName: weather.main!),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
                // Flexible(
                //   child: TextField(
                //     onChanged: (value) => update(value),
                //     decoration: InputDecoration(
                //       prefixIcon: const Icon(Icons.search),
                //       filled: true,
                //       fillColor: Colors.white70,
                //       hintText: 'Search city',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8),
                //         borderSide: BorderSide.none,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: cityList.length,
                      itemBuilder: (context, index) => Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            cityList[index],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            RefreshIndicator(
              onRefresh: () => weatherProvider.getWeather(),
              child: WeatherCard(
                locationName: weatherModel.name!,
                weatherDescription: weather.description!,
                weatherName: weather.main!,
              ),
            )
          ],
        ),
      ),
    );
  }

  update(String value) {}
}
