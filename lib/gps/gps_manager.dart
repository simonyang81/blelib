import 'dart:io';

import 'package:location/location.dart';

class GPSManager {
  factory GPSManager() => _getInstance();
  static GPSManager get instance => _getInstance();
  static GPSManager? _instance;

  GPSManager._internal();
  static GPSManager _getInstance() {
    _instance ??= GPSManager._internal();
    return _instance!;
  }

  Location location = Location();

  Future<void> openGPSGrant() async {
    if (!Platform.isAndroid) {
      return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted != PermissionStatus.granted) {
      permissionGranted = await location.requestPermission();
    }
  }

  Future<bool> isGPSGrant() async {
    if (!Platform.isAndroid) {
      return true;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<bool> isGPSOn() async {
    if (!Platform.isAndroid) {
      return true;
    }
    bool isGPSGran = await isGPSGrant();
    if (isGPSGran == false) {
      return false;
    } else {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        return false;
      }
    }
    return true;
  }
}
