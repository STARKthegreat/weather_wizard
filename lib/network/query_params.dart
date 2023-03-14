class QueryParams {
  QueryParams._();

  static Map<String, String> apiQp(
          {required String apiKey,
          required String cityID,
          String? lat,
          String? lon}) =>
      {
        'appid': apiKey,
        'id': cityID,
        'lat': lat!,
        'lon': lon!,
      };
}
