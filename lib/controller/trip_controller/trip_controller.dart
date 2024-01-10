import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';
import 'package:ride_with_passenger/Services/location_services/location_services.dart';
import 'package:ride_with_passenger/Services/user_preferences/user_preferences.dart';
import 'package:ride_with_passenger/model/all_trip_model/all_trip_model.dart';
import 'package:ride_with_passenger/model/on_going_trip_model/ongoing_trip_model.dart';
import 'package:ride_with_passenger/view/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:ride_with_passenger/view/splash_screen/splash_screen.dart';

import '../../constants/app_url/app_url.dart';
import '../../constants/enums.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/utils.dart';

class TripController extends GetxController{
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
  RefreshController refreshHomeController = RefreshController();

  final allTrips = AllTripModel().obs;

  Timer? timer;
  UserPreference userPreference = UserPreference();
  final _apiService = NetworkApiServices();
  RxBool isloading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }




  Future<dynamic> getAlltrips() async{

    try {
      isloading.value = true;
      dynamic response = await _apiService.getApi(AppUrl.getAllTripApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        allTrips.value = AllTripModel.fromJson(response);
        allTrips.refresh();
      }
      else if(response['status_code'] == 401){
        isloading.value = false;
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        isloading.value = false;
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      isloading.value = false;
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      isloading.value = false;
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }
}