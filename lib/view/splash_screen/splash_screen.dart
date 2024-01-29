import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ride_with_passenger/Services/location_services/location_services.dart';
import 'package:ride_with_passenger/controller/all_job_controller/all_job_controller.dart';
import 'package:ride_with_passenger/view/auth/login_screen.dart';
import 'package:get/get.dart';

import '../../Services/notification_services/notification_services.dart';
import '../../Services/splash_services.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  final _controller = Get.put(HomeScreenController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission();
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if(message != null) {
        // Utils.snackBar("notification", 'Tapped');
        // var model = Data.fromJson(json.decode(message.data['load']));
        // Get.offAll(JobDetailView(model: model));
      }
    });
    FirebaseMessaging.onMessage.listen(
          (message) async {
        if (message.notification != null) {
          // Show local notification using flutter_local_notifications plugin
          LocalNotificationService().playCustomSound(message.notification!.android!.sound!.split('.').first);
          LocalNotificationService().createAndDisplayNotification(message);
          _controller.countNotification();
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) async {
              print('A new onMessageOpenedApp event was published!');

        }
    );
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      splashScreen.isLogin();
    });
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset('assets/images/ridewithpassngers.png')
        ),
      ),
    );
  }

  Future<void> requestLocationPermission() async {
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
}
