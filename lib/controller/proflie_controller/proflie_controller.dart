import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Services/user_preferences/user_preferences.dart';
import 'package:ride_with_passenger/data/network/network_api_services.dart';

import '../../Widgets/image_to_base_64/image_to_64bytes.dart';
import '../../constants/app_url/app_url.dart';
import '../../utils/utils.dart';
import '../../view/auth/login_screen.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final licenseController = TextEditingController().obs;
  RxString avatar = ''.obs;
  final _apiService = NetworkApiServices();
  final RxBool isValid = false.obs;
   UserPreference userPreference = UserPreference();
  checkValidity() {
    if (emailController.value.text.isNotEmpty &&
        nameController.value.text.isNotEmpty &&
        phoneController.value.text.isNotEmpty &&
        licenseController.value.text.isNotEmpty &&
        avatar.value.isNotEmpty) {
      isValid.value = true;
      update();
    } else {
      isValid.value = false;
      update();
    }
  }
RxBool isloading = false.obs;
  Future<void> getProfile() async {
    try {
      isloading.value = true;
      dynamic response = await _apiService.getApi(AppUrl.getProfileApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        nameController.value.text = response['data']['name'];
        emailController.value.text = response['data']['email'];
        phoneController.value.text = response['data']['phone'];
        licenseController.value.text = response['data']['license_no'];
        avatar.value = response['data']['avatar'];
      }
      else if(response['status_code'] == 401){
        isloading.value = false;
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
        Utils.snackBar('Error', response['error']);
      }
      else{
        isloading.value = false;
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Get.back();
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }
  Future<void> updateProfile(BuildContext context) async {
    loadingStatusDialog(context, title: 'updating');
     Map<String, dynamic> data  = {
       "name": nameController.value.text,
       "email": emailController.value.text,
       "phone_number": phoneController.value.text,
        "license_no": licenseController.value.text,
       if(avatar.value != "" && !avatar.value.startsWith('http'))
         "image": await imageConverterTo64(avatar.value)
     };

    try {
      dynamic response = await _apiService.getApi(AppUrl.getProfileApi);
      if(response['status_code'] == 200){
        nameController.value.text = response['data']['name'];
        emailController.value.text = response['data']['email'];
        phoneController.value.text = response['data']['phone'];
        licenseController.value.text = response['data']['license_no'];
        avatar.value = response['data']['avatar'];
        Get.back();
        Utils.snackBar('Success', response['message']);
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