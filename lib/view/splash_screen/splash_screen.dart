import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:ride_with_passenger/Services/location_services/location_services.dart';
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
          (message) {
        if (message.data.isNotEmpty) {
          // Show local notification using flutter_local_notifications plugin
          LocalNotificationService().createAndDisplayNotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
            (RemoteMessage message) async {
          if (kDebugMode) {
            log("FirebaseMessaging.onMessageOpenedApp.listen");
          }
          try{
            if(message.data != null) {
              if (kDebugMode) {
                log("New Notification");
              }
              // Handle the notification data and navigate to the appropriate screen
              if (message.data['_id'] != null) {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => DemoScreen(
                //       id: message.data['_id'],
                //     ),
                //   ),
                // );
              }
            }
          }catch(e){
            log(e.toString());
          }
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
