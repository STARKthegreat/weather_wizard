import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_enums.dart';
import 'package:weather_wizard/network/network_helper.dart';
import 'package:weather_wizard/network/network_service.dart';
import 'package:weather_wizard/network/query_params.dart';
import 'package:weather_wizard/res/const/app_url.dart';
import 'package:weather_wizard/res/const/colors.dart';
import 'package:weather_wizard/view_models/city_id_provider.dart';
import 'package:weather_wizard/view_models/weather_provider.dart';
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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CityIdProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.kSecondary,
      ),
      darkTheme: ThemeData(
        primaryColor: AppColors.kPrimary,
      ),
      home: const Home(title: 'Weather Wizard'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, AsyncSnapshot<WeatherModel?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 25,
                      ),
                      Text('Error - $snapshot.error'),
                    ],
                  ),
                );
              } else if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                // return HomePage(weather: snapshot.data!.weather![1]);
                Weather weather = snapshot.data!.weather!.first;

                return HomePage(
                  weather: weather,
                );
              } else {
                return const Center(
                  child: Text('Oops Response is empty'),
                );
              }
          }
          // log(snapshot.hasData.toString());
          // if (snapshot.connectionState == ConnectionState.done &&
          //     snapshot.hasData) {
          //   final List<WeatherModel> weather =
          //       snapshot.data as List<WeatherModel>;
          //   return ListView.builder(
          //     itemCount: weather.length,
          //     itemBuilder: (context, index) {
          //       return HomePage(weatherModel: weather[index]);
          //     },
          //   );
          // } else if (snapshot.hasError) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: const [
          //         Icon(
          //           Icons.error_outline,
          //           color: Colors.red,
          //           size: 25,
          //         ),
          //         Text('Something Went Wrong')
          //       ],
          //     ),
          //   );
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
        },
      ),
    );
  }

  Future<WeatherModel?> getWeather() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      uri: AppUrl().baseUrl,
      queryParam: QueryParams.apiQp(
        apiKey: AppUrl().appid,
        cityID: '178040',
      ),
    );

    log(response!.statusCode.toString());
    WeatherModel output = weatherModelFromJson(response.body);
    return await NetworkHelper.filterResponse(
      callBack: (json) {
        log(output.base!);
        return output;
      },
      response: response,
      parameterName: CallBackParameterName.all,
      onFailureCallBackWithMessage: (errorType, msg) {
        log('Error Type-$errorType - Message: $msg');
      },
    );
  }
}
