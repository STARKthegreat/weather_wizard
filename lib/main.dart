import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_wizard/models/weather_model.dart';
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

class Home extends StatelessWidget {
  const Home({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.kPrimary,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: weatherProvider.getWeather(),
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
                WeatherModel weatherModel = snapshot.data!;

                return HomePage(
                  weather: weather,
                  weatherModel: weatherModel,
                );
              } else {
                return const Center(
                  child: Text('Oops Response is empty'),
                );
              }
          }
        },
      ),
    );
  }
}
