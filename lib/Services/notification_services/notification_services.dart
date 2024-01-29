// import 'dart:developer';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // class firebaseNotificationToken{
// //   static FirebaseMessaging firebaseMessaging =FirebaseMessaging.instance;
// //   static Future<void> getToken() async{
// //     await firebaseMessaging.requestPermission();
// //     await firebaseMessaging.getToken().then((token){
// //       if(token != null){
// //         log('FCM Token : $token');
// //       }
// //     });
// //   }
// // }
// class NotificationsUtils {
//   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   static String? fcmToken;
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   static Future<void> init() async {
//     await askforPermission();
//   }
//
//   static Future<void> askforPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
//     log('Notification Permission======> ${settings.authorizationStatus}}');
//     if (settings.authorizationStatus == AuthorizationStatus.denied ||
//         settings.authorizationStatus == AuthorizationStatus.notDetermined) {
//       await _firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: true,
//         badge: true,
//         carPlay: false,
//         criticalAlert: true,
//         provisional: false,
//         sound: true,
//       );
//       _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       log('Notification Allowed======>');
//     }
//     _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     log('Notification Permission======> ${settings.authorizationStatus}}');
//     fcmToken = await _firebaseMessaging.getToken();
//     log('fcmToken : $fcmToken');
//     _firebaseMessaging.onTokenRefresh.listen((event) {
//       fcmToken = event;
//       log('FCM Token Refreshed: $fcmToken');
//       });
//     }
//
//   static void createanddisplaynotification(RemoteMessage message) async {
//     try {
//
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       // const IOSNotificationDetails iOSPlatformChannelSpecifics =
//       // IOSNotificationDetails();
//       //
//       // const NotificationDetails platformChannelSpecifics =
//       // NotificationDetails(iOS: iOSPlatformChannelSpecifics);
//       // await _notificationsPlugin.show(
//       //   id,
//       //   message.notification.title,
//       //   message.notification.body,
//       //   platformChannelSpecifics,
//       //   payload: message.data['_id'],
//       // );
//
//       const NotificationDetails notificationDetails = NotificationDetails(
//         // iOS: IOSNotificationDetails(
//         //   badgeNumber: 02,
//         //   presentAlert:true,
//         //   presentBadge: true,
//         //   presentSound: true,
//         // ),
//         android: AndroidNotificationDetails(
//           "Pristine Connection",
//           "PC_LLC",
//           importance: Importance.max,
//           priority: Priority.high,
//           styleInformation: BigTextStyleInformation(''),
//         ),
//       );
//
//       await _notificationsPlugin.show(
//         id,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['_id'],
//       );
//     } on Exception catch (e) {
//       debugPrint("$e");
//     }
//   }
//   }

import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Services/user_preferences/user_preferences.dart';

import '../../constants/global.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  UserPreference userPreference = UserPreference();
  AudioPlayer audioPlayer = AudioPlayer();
   Future<String?> initialize() async {
    // Initialization settings for Android

    InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
        )
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
    );
    // Retrieve FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    Global().setFcmToken(fcmToken!);
    if (kDebugMode) {
      print('Firebase Cloud Messaging token: $fcmToken');
    }
    return fcmToken;
  }
   void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
       NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "pushnotificationapp",
            "notifications",
            importance: Importance.high,
            priority: Priority.high,
            playSound: false,
            audioAttributesUsage: AudioAttributesUsage.alarm,
            sound: RawResourceAndroidNotificationSound(message.notification!.android!.sound!.split('.').first),
          ),
          iOS: DarwinNotificationDetails(
            presentSound: true,
            interruptionLevel: InterruptionLevel.active,
            sound: message.notification!.android!.sound!.split('.').first,
            presentAlert: true,
          )
      );
///todo: for ios need to create resource folder in runner by right click on runner and create new resource folder and add sound file in it
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['icon'],
      );

    } catch (e) {
      if (kDebugMode) {
        print('Failed to create and display notification: $e');
      }
    }
  }
  AudioPlayer _audioPlayer = AudioPlayer();
  playCustomSound(String value) async {
    try {
      if (value == "anychange") {
        await _audioPlayer.play(
            AssetSource("alerts/anychange.mp3"), volume: 100.0, mode: PlayerMode.mediaPlayer);
      }
     else if (value == "newtrip") {
        await _audioPlayer.play(
            AssetSource("alerts/newtrip.mp3"), volume: 100.0);
      }
      else if (value == "notificationfromplatform") {
        await _audioPlayer.play(
            AssetSource("alerts/notificationfromplatform.mp3"), volume: 100.0);
      }
      else if(value == "remindertrip"){
        await _audioPlayer.play(
            AssetSource("alerts/remindertrip.mp3"),
          volume: 100.0,
        );
      }
      else{

      }
    } catch (e) {
      log(e.toString());
    }
  }

}
