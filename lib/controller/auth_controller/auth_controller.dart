
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';


class AuthController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  // final _api = LoginRepository();
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final changePasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final RxBool isValid = false.obs;
  checkValidity() {
    if (newPasswordController.value.text.isNotEmpty
    ) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }
  // UserPreference userPreference = UserPreference();
  // Future<void> login(BuildContext context) async {
  //   try {
  //     loadingStatusDialog(context, title: 'Signing in');
  //     Map<String, dynamic> data = {
  //       "email": emailController.value.text,
  //       "password": passwordController.value.text,
  //     };
  //     _api.loginApi(data).then((value) {
  //       if (value['status_code'] == 200) {
  //         Get.back();
  //         Data userData = Data(
  //           bearerToken: value['data']['bearer_token'],
  //         );
  //         LoginModel userModel = LoginModel(
  //           statusCode: value['status_code'],
  //           message: value['message'],
  //           error: value['error'],
  //           data: userData,
  //           isLogin: true,
  //         );
  //         userPreference.saveUser(userModel).then((value) {
  //           // releasing resources because we are not going to use this
  //           Get.delete<AuthController>();
  //           emailController.value.clear();
  //           passwordController.value.clear();
  //           Get.offAll(BottomNavigationBarScreen())!.then((value) {});
  //           Utils.snackBar('Login', 'Login successfully');
  //         }).onError((error, stackTrace) {
  //           Get.back();
  //           Utils.snackBar('Error', error.toString());
  //         });
  //       } else if(value['status_code'] == 400) {
  //         Get.back();
  //         errorOverlay(context,message: value['message'],title: 'Signin Failed',okLabel: 'ok');
  //         // Go back to SignInView
  //       }
  //     }).onError((error, stackTrace) {
  //       Get.back(); // Close the dialog in case of error
  //       errorOverlay(context,
  //           title: 'Signin Failed', message: error.toString(), okLabel: 'ok');
  //       print("Error while LoginIn ${error.toString()}");// Go back to SignInView in case of error
  //     });
  //   } catch (e) {
  //     Get.back();
  //     errorOverlay(context,
  //         title: 'Signin Failed', message: e.toString(), okLabel: 'ok');
  //     log(e.toString());
  //   }
  // }
  // Future<void> changePassword(BuildContext context) async {
  //   try {
  //     loadingStatusDialog(context, title: 'updating password');
  //     Map<String, dynamic> data = {
  //       "password": newPasswordController.value.text,
  //     };
  //     _api.updatePassword(data).then((value){
  //       if(value['status_code'] == 200){
  //         Get.back();
  //         Utils.snackBar('Password', value['message']);
  //         newPasswordController.value.clear();
  //       }
  //       else{
  //         Get.back();
  //         Utils.snackBar('Error', value['error']);
  //       }
  //     }).onError((error, stackTrace) {
  //       Get.back();
  //       Utils.snackBar('Error', 'Network Error');
  //     });
  //   } catch (e) {
  //     errorOverlay(context,
  //         title: 'Updation Failed', message: e.toString(), okLabel: 'ok');
  //     log(e.toString());
  //   }
  // }

}