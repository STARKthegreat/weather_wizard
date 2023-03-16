class QueryParams {
  QueryParams._();

  static Map<String, String> apiQp({
    required String lat,
    required String lon,
    required String apiKey,
  }) =>
      {
        'appid': apiKey,
        'lat': lat,
        'lon': lon,
      };
}
