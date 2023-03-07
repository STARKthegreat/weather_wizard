import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_enums.dart';
import 'package:weather_wizard/network/network_helper.dart';
import 'package:weather_wizard/network/network_service.dart';
import 'package:weather_wizard/network/query_params.dart';
import 'package:weather_wizard/res/const/app_url.dart';
import 'package:weather_wizard/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CloudsAdapter());
  Hive.registerAdapter(WindAdapter());
  Hive.registerAdapter(MainAdapter());
  Hive.registerAdapter(SysAdapter());
  Hive.registerAdapter(CoordAdapter());
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(WeatherModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Weather Wizard'),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          log(snapshot.data.toString());
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final List<WeatherModel> weather =
                snapshot.data as List<WeatherModel>;
            return ListView.builder(
              itemCount: weather.length,
              itemBuilder: (context, index) {
                return HomePage(weatherModel: weather[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 25,
                  ),
                  Text('Something Went Wrong')
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  static Future<List<WeatherModel>?> getWeather() async {
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
        log(json.toString());
      },
      response: response,
      parameterName: CallBackParameterName.all,
      onFailureCallBackWithMessage: (errorType, msg) {
        log('Error Type-$errorType - Message: $msg');
      },
    );
  }
}
