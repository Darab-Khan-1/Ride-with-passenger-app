import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';
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
  final ongoingTrip = OnGoingTripModel().obs;
  final allTrips = AllTripModel().obs;
  late GoogleMapController mapController;
  Timer? timer;
  Set<Marker> markers = {};
  List<LatLng> routeCoordinates = [];
  var currentPosition = Rx<LocationData?>(null);
  Rx<CameraPosition> initialLocation = CameraPosition(
      target: LatLng(31.4535128, 74.2518413), zoom: 12).obs;
  RxDouble zoomValue = 14.0.obs;
  void updateZoomValue(double value){
    zoomValue.value = value;
    update();
  }
  UserPreference userPreference = UserPreference();
  final _apiService = NetworkApiServices();
  RxBool isloading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
    OngoingTrip();
  }


  Future<void> getCurrentLocation() async {
    try {
      await Location. instance.onLocationChanged.listen((locationData) async {
        currentPosition.value = locationData;
        // print('CURRENT POS: ${currentPosition.value}');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(locationData.latitude!, locationData.longitude!),
              zoom: zoomValue.value,
            ),
          ),
        );
        update();
      });
    } catch (e) {
      print("The Error in Getting Current user function ${e.toString()}");
    }
  }

  Future<dynamic> OngoingTrip() async{

    try {
      setRxRequestStatus(Status.LOADING);
      dynamic response = await _apiService.getApi(AppUrl.ongoingTripApi);
      if(response['status_code'] == 200){
        setRxRequestStatus(Status.COMPLETED);
        ongoingTrip.value = OnGoingTripModel.fromJson(response);
        ongoingTrip.refresh();
      }
      else if(response['status_code'] == 401){
        setRxRequestStatus(Status.ERROR);
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        setRxRequestStatus(Status.ERROR);
        Utils.snackBar('Error', response['error']);
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


  Future<dynamic> startTrip( int tripId) async{
    try {
      isloading.value = true;
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.startTripApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        Utils.snackBar('Success', response['message']);
        Get.offAll(const BottomNavBarScreen());
        // OngoingTrip();
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