// ignore_for_file: prefer_const_constructors, avoid_print, empty_catches

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  late final double latitude;
  late final double longitude;

  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        latitude = position.latitude;
        longitude = position.longitude;
      } catch (e) {
        print("My Error : $e !!");
      }
    } else {
      throw Exception('Error');
    }
  }
}
