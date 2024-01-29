
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../constants/app_url/app_url.dart';

class LocationService {
  static Future PermissionRequest() async {
    try {
      // await showDialog(
      //     context: Get.context!,
      //     barrierDismissible: false,
      //     builder: (context) => AlertDialog(
      //       title: const Text('Alert!'),
      //       content: const Text('Please Allow Location All the time for live Tracking'),
      //       actions: [
      //         TextButton(onPressed: (){
      //           Navigator.pop(context);
      //         }, child: const Text('Ok'))
      //       ],
      //     ));
      PermissionStatus permissionStatus =
          await Location.instance.hasPermission();
      do {
        permissionStatus = await Location.instance.requestPermission();
        if (permissionStatus == PermissionStatus.granted) {
          await Location.instance.enableBackgroundMode(enable: true);
          Location.instance.changeSettings(
              accuracy: LocationAccuracy.high, interval: 1000);
          return;
        }
      } while (permissionStatus != PermissionStatus.granted &&
          permissionStatus != PermissionStatus.grantedLimited);
      return;
    } catch (e) {
      rethrow;
    }
  }

 static Future requestLocationPermission() async {
    bool serviceEnabled = await Location.instance.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location.instance.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    // Check if the location permission is already granted
    var permissionStatus = await Location.instance.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await Location.instance.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        PermissionStatus.values.forEach((element) {
          print(element);
        });
        return;
      }
    }


  }
  static Future updateLocation(LocationData locationData, String id) async {
    DateTime originalTime = DateTime.fromMillisecondsSinceEpoch(locationData.time!.toInt());
    DateTime utcTime = originalTime.toUtc();
    Uri uri = Uri.http(AppUrl.serverUrl, '/', {
      'id': id,
      'timestamp': utcTime.millisecondsSinceEpoch.toString(),
      'lat': locationData.latitude.toString(),
      'lon': locationData.longitude.toString(),
      'speed': locationData.speed.toString(),
      'bearing': locationData.heading.toString(),
      'altitude': locationData.altitude.toString(),
      'accuracy': locationData.accuracy.toString(),
      'batt': '100'
    });

    await http.get(uri).then((value) {
      if(value.statusCode == 200) {
        log(value.statusCode.toString());
        log("location updating");
      }
      return value.statusCode;
    });
  }

  static Future<LocationData> getLocation() async {
    try {
      await Location.instance.requestService();
      return await Location.instance.getLocation();
    } catch (e) {
      rethrow;
    }
  }
}
