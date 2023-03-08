enum NetworkResponseErrorType {
  socket,
  exception,
  responseEmpty,
  didNotSucceed,
}

enum CallBackParameterName {
  all,
  weather,
}

extension CallBackParameterNameExtension on CallBackParameterName {
  dynamic getJson(json) {
    switch (this) {
      case CallBackParameterName.all:
        return json;
      case CallBackParameterName.weather:
        return json['weather'];
    }
  }
}
