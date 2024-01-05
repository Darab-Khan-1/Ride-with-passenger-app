import 'dart:async';
import 'package:ride_with_passenger/Services/user_preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/bottom_nav_bar/bottom_nav_bar_view.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      SharedPreferences.getInstance().then((prefs) {
        // if (prefs.containsKey('understood')) {
          if (value.isLogin == false || value.isLogin == null) {
                  Timer(const Duration(seconds: 3), () => Get.offAll(LoginScreen()));
                } else {
                  Timer(const Duration(seconds: 3), () => Get.offAll(BottomNavBarScreen()));
                }
        // } else {
        //   Timer(const Duration(seconds: 3),
        //           () => Get.to(AskForPermission()));
        // }
      });
    });
  }
}