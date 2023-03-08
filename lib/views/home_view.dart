import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_helper.dart';
import 'package:weather_wizard/network/network_service.dart';
import 'package:weather_wizard/network/query_params.dart';
import 'package:weather_wizard/res/const/app_url.dart';
import 'package:weather_wizard/views/city_stories.dart';
import 'package:weather_wizard/views/weather_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.weather,
  });
  final Weather weather;
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
                  onPressed: () {},
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
              onRefresh: () => getWeather(),
              child: Flexible(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) => WeatherCard(
                    weatherDescription: weather.description!,
                    weatherName: weather.main!,
                    locationName: 'Yala',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<WeatherModel>?> getWeather() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      url: AppUrl().baseUrl,
      queryParam: QueryParams.apiQp(
        apiKey: AppUrl().appid,
        cityID: '178040',
      ),
    );

    log(response!.statusCode.toString());

    return await NetworkHelper.filterResponse(
      callBack: (json) {
        WeatherModel.fromJson(json);
      },
      response: response,
      onFailureCallBackWithMessage: (errorType, msg) {
        log('Error Type-$errorType - Message: $msg');
      },
    );
  }
}
