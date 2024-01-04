
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import '../../Services/user_preferences/user_preferences.dart';
import '../../constants/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/utils.dart';


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
      final response = _apiService.postApi(data, AppUrl.loginApi);
      // if(response['status_code'] == 200){
      //   Get.back();
      //   // userPreference.saveUser(response['data']);
      //   // Get.offAll(BottomNavigationBarScreen());
      // }
      // else if(response['status_code'] == 401){
      //   Get.back();
      //   Utils.snackBar('Error', response['error']);
      // }
      // else{
      //   Get.back();
      //   Utils.snackBar('Error', response['error']);
      // }
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
  Future<void> changePassword(BuildContext context, {required String oldPassword, required String newPassword}) async {
    try {
      loadingStatusDialog(context, title: 'updating password');
      Map<String, dynamic> data = {
        "password": newPassword,
      };
      // final response = _apiService.updateApi(data, AppUrl.changePasswordApi);
      // if(response['status_code'] == 200){
      //   Get.back();
      //   Utils.snackBar('Password', response['message']);
      //   // newPasswordController.value.clear();
      //   // oldPasswordController.value.clear();
      //   // logout(context);
      // }
      // else if (response['status_code'] == 401){
      //   Get.back();
      //   Utils.snackBar('Error', response['error']);
      // }
      // else{
      //   Get.back();
      //   Utils.snackBar('Error', response['error']);
      // }
    } on SocketException catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Updation Failed',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      errorOverlay(context,
          title: 'Updation Failed', message: e.toString(), okLabel: 'ok');
      log(e.toString());
    }
  }

}