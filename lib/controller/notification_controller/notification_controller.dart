import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ride_with_passenger/constants/app_url/app_url.dart';
import 'package:ride_with_passenger/data/network/network_api_services.dart';

import '../../Services/user_preferences/user_preferences.dart';
import '../../constants/enums.dart';
import '../../model/notification_model/notification_model.dart';
import '../../utils/utils.dart';
import '../../view/splash_screen/splash_screen.dart';

class NotificationController extends GetxController{
  RxBool isloading = false.obs;
  final notificationList = NotificationModel().obs;
  final _api = NetworkApiServices();
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  UserPreference userPreference = UserPreference();
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
RxBool seen = false.obs;

  @override
  onInit(){
    super.onInit();
    getNotification();
  }


  Future<void> getNotification() async {
    try {
      setRxRequestStatus(Status.LOADING);
      dynamic response = await NetworkApiServices().getApi(AppUrl.getNotification);
      if(response['status_code'] == 200){
        setRxRequestStatus(Status.COMPLETED);
        notificationList.value = NotificationModel.fromJson(response);
        seenNotification();
        update();
        // OngoingTrip();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        setRxRequestStatus(Status.ERROR);
      }
    } on SocketException catch (e) {
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      setRxRequestStatus(Status.ERROR);
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }
  Future<void> seenNotification() async {
    try {
      dynamic response = await NetworkApiServices().getApi(AppUrl.seenNotification);
      if(response['status_code'] == 200){
        seen.value = true;
        update();
        // OngoingTrip();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        log(response['error']);
      }
    } on SocketException catch (e) {
      setRxRequestStatus(Status.ERROR);

    }
    catch (e) {
      setRxRequestStatus(Status.ERROR);
      log(e.toString());
    }
  }
}