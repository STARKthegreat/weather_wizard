import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:weather_wizard/res/const/app_res_string.dart';

class CityIdProvider extends ChangeNotifier {
  List items = [];
  Future<List> readJson() async {
    final String response = await rootBundle.loadString(AppAssets.cityJson);
    final data = json.decode(response);
    items = data["cities"];
    notifyListeners();
    return items;
  }
}
