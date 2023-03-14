import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  static late Position myLocation;
  Future<Position> getLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return Future.error(
          'You\'ll have to provide location access for the app to run properly');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'You\'ll have to provide location access for the app to run properly');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are denied forever');
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return await Geolocator.getCurrentPosition();
    }

    myLocation = await Geolocator.getCurrentPosition();
    log("$myLocation");
    return myLocation;
  }
}
