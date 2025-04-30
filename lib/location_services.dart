import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class LocationServices {
   //location services
  loc.Location location = loc.Location();
  final bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  loc.LocationData? locationData;

  get placemarks => null;

  // Future<void> _requestLocationPermission() async {
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  // }

  Future<Object> initializeLocation() async {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        debugPrint('Location permission not granted');
        return 'Location permission not granted';
      }
    }

    //location service enabled and granted
    locationData = await location.getLocation();
    
    try {
      // Get the city name from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData!.latitude!,
        locationData!.longitude!,
      );

      // Return the city name, fallback to "Unknown" if city is not found
     return [placemarks[0].locality, locationData!.latitude, locationData!.longitude];
    } catch (e) {
      debugPrint("Error retrieving city: $e");
      return "Error retrieving city";
    }
    
  }
}