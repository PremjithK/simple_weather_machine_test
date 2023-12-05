import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  final StreamController _locationPermissionController = StreamController.broadcast();

  Stream get locationPermissionStream => _locationPermissionController.stream;

  Future<void> checkLocationPermission() async {
    final status = await Geolocator.isLocationServiceEnabled();
    _locationPermissionController.add(status);
  }

  void dispose() {
    _locationPermissionController.close();
  }
}
