
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:ride_with_passenger/constants/global.dart';
import 'package:ride_with_passenger/view/auth/login_screen.dart';
import 'package:ride_with_passenger/view/home_screen/home_screen.dart';
import 'package:ride_with_passenger/view/splash_screen/splash_screen.dart';

import '../../Services/user_preferences/user_preferences.dart';
import '../../constants/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../model/login_model/login_model.dart';
import '../../utils/utils.dart';
import '../../view/bottom_nav_bar/bottom_nav_bar_view.dart';


class AuthController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  // final _api = LoginRepository();
final _apiService = NetworkApiServices();

  UserPreference userPreference = UserPreference();
  Future<dynamic> login(BuildContext context, {required String email, required String password}) async {
    try {
      loadingStatusDialog(context, title: 'Signing in');
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };
      dynamic response = await _apiService.postApi(data, AppUrl.loginApi);

      if(response['status_code'] == 200){
        LoginModel userModel = LoginModel.fromJson(response);
        Get.back();
        var fcmToken = Global().fcmToken;
        await userPreference.saveUser(userModel);
        await updateFcmToken(token: fcmToken!);
        Get.offAll(BottomNavBarScreen());
      }
      else if(response['status_code'] == 401){
        Get.back();
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
        Utils.snackBar('Error', response['error']);
      }
      else{
        Get.back();
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Signin Failed',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Signin Failed', message: "Something went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }
  Future<dynamic> changePassword(BuildContext context, {required String oldPassword, required String newPassword}) async {
    try {
      loadingStatusDialog(context, title: 'updating password');
      Map<String, dynamic> data = {
        "old_password": oldPassword,
        "new_password": newPassword,
      };
      dynamic response = await _apiService.updateApi(data, AppUrl.changePasswordApi);
      if(response['status_code'] == 200){
        Get.back();
        Utils.snackBar('Password', response['message']);
        // newPasswordController.value.clear();
        // oldPasswordController.value.clear();
        // logout(context);
      }
      else if (response['status_code'] == 401){
        Get.back();
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        Get.back();
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Error!',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Error!', message: "Something Went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }
  Future<dynamic> updateFcmToken({required String token}) async {
    try {
      Map<String, dynamic> data = {
        "fcm": token,
      };
      dynamic response = await _apiService.postApi(data, AppUrl.updateFcmApi);
      if(response['status_code'] == 200){
        log(response['message']);
      }
      else if (response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        log(response['error']);
      }
    } on SocketException catch (e) {
      log(e.message);
    }
    catch (e) {
      log(e.toString());
    }
  }
logoutApi(BuildContext context) async {

  try {
    loadingStatusDialog(context, title: 'Logging Out');
    dynamic response = await _apiService.getApi(AppUrl.logoutApi);
    if(response['status_code'] == 200){
      userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
    }
    else if(response['status_code'] == 401){
      Get.back();
      userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
      Utils.snackBar('Error', response['error']);
    }
    else{
      Get.back();
      Utils.snackBar('Error', response['error']);
    }
  } on SocketException catch (e) {
    Get.back();
    errorOverlay(context,
        title: 'Error!',
        message: e.message,
        okLabel: 'ok');
  }
  catch (e) {
    Get.back();
    errorOverlay(context,
        title: 'Error!', message: "Something went Wrong", okLabel: 'ok');
    log(e.toString());
  }
}

}