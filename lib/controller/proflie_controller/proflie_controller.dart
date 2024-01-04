import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getProfile();
  }
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  RxString avatar = ''.obs;
  // final _api = ProfileRepository();
  final RxBool isValid = false.obs;
  checkValidity() {
    if (emailController.value.text.isNotEmpty &&
        nameController.value.text.isNotEmpty &&
        phoneController.value.text.isNotEmpty &&
        avatar.value.isNotEmpty) {
      isValid.value = true;
      update();
    } else {
      isValid.value = false;
      update();
    }
  }
RxBool isloading = false.obs;
  // Future<void> getProfile() async {
  //   isloading.value = true;
  //   _api.getProfile().then((value) {
  //     isloading.value = false;
  //     if(value["status_code"] == 200){
  //       nameController.value.text = value["data"]["name"];
  //       emailController.value.text = value["data"]["email"];
  //       phoneController.value.text = value["data"]["phone_number"];
  //       avatar.value = value["data"]["image"];
  //       checkValidity();
  //     }
  //     else{
  //       Utils.snackBar('Error', value["error"]);
  //     }
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     print(error.toString());
  //   });
  // }
  // Future<void> updateProfile(BuildContext context) async {
  //   loadingStatusDialog(context, title: 'updating');
  //    Map<String, dynamic> data  = {
  //      "name": nameController.value.text,
  //      "email": emailController.value.text,
  //      "phone_number": phoneController.value.text,
  //      if(avatar.value != "" && !avatar.value.startsWith('http'))
  //        "image": await imageConverterTo64(avatar.value)
  //    };
  //   _api.updateProfile(data).then((value) {
  //     Get.back();
  //     if(value['status_code'] == 200){
  //       Utils.snackBar('Profile Updated', 'Successful');
  //       getProfile();
  //     }
  //     else{
  //       Utils.snackBar('Error', value['message']);
  //     }
  //   }).onError((error, stackTrace) {
  //     Get.back();
  //     Utils.snackBar('Error', 'Network Error');
  //   });
  // }
  //
  // logoutApi() async {
  //   _api.logoutApi().then((value) async {
  //     if(value["status_code"] == 200){
  //       Utils.snackBar('Logout', value["message"]);
  //       await UserPreference().removeUser();
  //       Get.offAll(SplashScreen());
  //     }
  //     else{
  //       Utils.snackBar('Error', value["error"]);
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.snackBar('Error', error.toString());
  //   });
  // }
}