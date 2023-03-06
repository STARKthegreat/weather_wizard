// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';
part 'weather_model.g.dart';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class WeatherModel extends HiveObject {
  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @HiveField(0)
  Coord? coord;
  @HiveField(1)
  List<Weather>? weather;
  @HiveField(2)
  String? base;
  @HiveField(3)
  Main? main;
  @HiveField(4)
  int? visibility;
  @HiveField(5)
  Wind? wind;
  @HiveField(6)
  Clouds? clouds;
  @HiveField(7)
  int? dt;
  @HiveField(8)
  Sys? sys;
  @HiveField(9)
  int? timezone;
  @HiveField(10)
  int? id;
  @HiveField(11)
  String? name;
  @HiveField(12)
  int? cod;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        weather: json["weather"] == null
            ? []
            : List<Weather>.from(
                json["weather"]!.map((x) => Weather.fromJson(x))),
        base: json["base"],
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        visibility: json["visibility"],
        wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
        clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
        dt: json["dt"],
        sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
      );

  Map<String, dynamic> toJson() => {
        "coord": coord?.toJson(),
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "base": base,
        "main": main?.toJson(),
        "visibility": visibility,
        "wind": wind?.toJson(),
        "clouds": clouds?.toJson(),
        "dt": dt,
        "sys": sys?.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
      };
}

@HiveType(typeId: 2)
class Clouds extends HiveObject {
  Clouds({
    this.all,
  });
  @HiveField(0)
  int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

@HiveType(typeId: 3)
class Coord extends HiveObject {
  Coord({
    this.lon,
    this.lat,
  });

  @HiveField(0)
  double? lon;
  @HiveField(1)
  double? lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

@HiveType(typeId: 4)
class Main extends HiveObject {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });
  @HiveField(0)
  double? temp;
  @HiveField(1)
  double? feelsLike;
  @HiveField(2)
  double? tempMin;
  @HiveField(3)
  double? tempMax;
  @HiveField(4)
  int? pressure;
  @HiveField(5)
  int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

@HiveType(typeId: 5)
class Sys extends HiveObject {
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @HiveField(0)
  int? type;
  @HiveField(2)
  int? id;
  @HiveField(3)
  String? country;
  @HiveField(4)
  int? sunrise;
  @HiveField(5)
  int? sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json["type"],
        id: json["id"],
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

@HiveType(typeId: 6)
class Weather extends HiveObject {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? main;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

@HiveType(typeId: 7)
class Wind extends HiveObject {
  Wind({
    this.speed,
    this.deg,
  });

  @HiveField(0)
  double? speed;
  @HiveField(1)
  int? deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}
