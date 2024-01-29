import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/constants/string.dart';
import 'package:ride_with_passenger/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Services/notification_services/notification_services.dart';
import 'constants/theme.dart';
import 'firebase_options.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  // Handle background messages here
  print("Handling background message: ${message.messageId}");
  LocalNotificationService().playCustomSound(message.notification!.android!.sound!.split('.').first);
  // LocalNotificationService().createAndDisplayNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await LocalNotificationService().initialize();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme(context),
      home: SplashScreen(),
    );
  }
}

