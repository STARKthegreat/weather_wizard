import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  late Position location;
  bool isLoading = true;
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
    location = await Geolocator.getCurrentPosition();
    isLoading = false;
    notifyListeners();
    return location;
  }
}
