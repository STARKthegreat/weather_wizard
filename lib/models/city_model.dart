// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    this.id,
    this.name,
    this.state,
    this.country,
    this.coord,
  });

  int? id;
  String? name;
  String? state;
  Country? country;
  Coord? coord;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        state: json["state"],
        country: countryValues.map[json["country"]]!,
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state": state,
        "country": countryValues.reverse[country],
        "coord": coord?.toJson(),
      };
}

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  double? lon;
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

enum Country { KE }

final countryValues = EnumValues({"KE": Country.KE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
