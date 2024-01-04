import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/constants/string.dart';
import 'package:ride_with_passenger/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants/theme.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

