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
                Flexible(
                  child: TextField(
                    onChanged: (value) => update(value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: 'Search city',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: cityList[index]),
                    ),
                  ),
                ),
              ],
            ),
            RefreshIndicator(
              onRefresh: () => getWeather(),
              child: WeatherCard(
                locationName: 'Yala',
                weatherDescription: weather.description!,
                weatherName: weather.main!,
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
      uri: AppUrl().baseUrl,
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

  update(String value) {}
}
