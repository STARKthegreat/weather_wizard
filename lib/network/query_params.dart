class QueryParams {
  QueryParams._();

  static Map<String, String> apiQp(
          {required String apiKey, required String cityID}) =>
      {'appid': apiKey, 'id': cityID};
}
