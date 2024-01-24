import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ride_with_passenger/Services/location_services/location_services.dart';
import 'package:ride_with_passenger/Services/user_preferences/user_preferences.dart';

import '../../constants/app_url/app_url.dart';
import '../../constants/enums.dart';
import '../../data/network/network_api_services.dart';
import '../../model/on_going_trip_model/ongoing_trip_model.dart';
import '../../utils/utils.dart';
import '../../view/bottom_nav_bar/bottom_nav_bar_view.dart';
import '../../view/splash_screen/splash_screen.dart';
class HomeScreenController extends GetxController {
  RefreshController refreshAllJobController = RefreshController();
  String? uid;
  @override
  Future<void> onInit() async {
    super.onInit();
     uid = await userPreference.uid;
    getCurrentLocation();
  }
  // RxBool isloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
  ScrollController scrollController = ScrollController();
  UserPreference userPreference = UserPreference();
  var currentPosition = Rx<LocationData?>(null);
  Rx<CameraPosition> initialLocation = CameraPosition(
      target: LatLng(31.4535128, 74.2518413), zoom: 12).obs;
  RxDouble zoomValue = 14.0.obs;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  List<LatLng> routeCoordinates = [];
  final _apiService = NetworkApiServices();
  final ongoingTrip = OnGoingTripModel().obs;
  void updateZoomValue(double value){
    zoomValue.value = value;
    update();
  }


  Future<void> getCurrentLocation() async {
    try {
      await Location. instance.onLocationChanged.listen((locationData) async {
        currentPosition.value = locationData;
        print('CURRENT POS: ${currentPosition.value}');
        await LocationService.updateLocation(locationData, uid! );
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

  Future<dynamic> tripsCircleApi() async{
    try {
      routeCoordinates.clear();
      markers = {};
      setRxRequestStatus(Status.LOADING);
      dynamic response = await _apiService.getApi(AppUrl.ongoingTripApi);
      if(response['status_code'] == 200){
        ongoingTrip.value = OnGoingTripModel.fromJson(response);
        // refresh();
        if(ongoingTrip.value.data == null || ongoingTrip.value.data == ""){
          markers = {};
          routeCoordinates = [];
        }
        else{
          routeFunction(ongoingTrip.value).then((value) {
            ongoingTrip.refresh();
          });
        }
        setRxRequestStatus(Status.COMPLETED);
        // setRxRequestStatus(Status.COMPLETED);
        update();
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

  Future<dynamic> startTrip( int tripId) async{
    try {
      setRxRequestStatus(Status.LOADING);
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.startTripApi);
      if(response['status_code'] == 200){
        setRxRequestStatus(Status.COMPLETED);
        Utils.snackBar('Success', response['message']);
        Get.offAll(const BottomNavBarScreen());
        // OngoingTrip();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        setRxRequestStatus(Status.ERROR);
        Utils.snackBar('Error', response['message']);
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

  Future<dynamic> endTrip( int tripId) async{
    try {
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.endTripApi);
      if(response['status_code'] == 200){
        Utils.snackBar('Success', response['message']);
        // tripsCircleApi();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }

  Future<dynamic> exitStop( int tripId, currentId) async{
    try {
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
        "stop_id": currentId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.exitStopApi);
      if(response['status_code'] == 200){
        // Utils.snackBar('Success', response['message']);
        // tripsCircleApi();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }

  Future<dynamic> stopTrip( int tripId, int nextStopId) async{
    try {
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
        "stop_id": nextStopId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.stopTripApi);
      if(response['status_code'] == 200){
        // Utils.snackBar('Success', response['message']);

      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }

  Future<dynamic> pickupTrip(int tripId) async{
    try {
      Map<String, dynamic> data = {
        "trip_id": tripId.toString(),
      };
      dynamic response = await _apiService.postApi(data, AppUrl.pickupTripApi);
      if(response['status_code'] == 200){
        // isloading.value = false;
        // Utils.snackBar('Success', response['message']);
        // tripsCircleApi();
        // update();
      }
      else if(response['status_code'] == 401){
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll(const SplashScreen()));
      }
      else{
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }

  routeFunction(OnGoingTripModel value) async{
    if(value.data!.currentStop == 0){
      if(value.data!.status == "destination" ){
        // endTrip(value.data!.id!);
      }
      else{
        if(value.data!.status == "started"){
          await fetchDirections(double.parse(value.data!.lat!), double.parse(value.data!.long!), "Pickup Point" );
        }
        else if(value.data!.status == "in-transit"){
          if(value.data!.nextStop!.type == "destination"){
            await fetchDirections(double.parse(value.data!.nextStop!.lat!), double.parse(value.data!.nextStop!.long!), "DropOff Point" );
          }
          else{
            await fetchDirections(double.parse(value.data!.nextStop!.lat!), double.parse(value.data!.nextStop!.long!), "Next Stop" );
          }

        }
        else{

        }
        // await fetchDirections(double.parse(value.data!.lat!), double.parse(value.data!.long!), "Pickup Point" );
      }
    }
  }

  Future<void> fetchDirections(double dropLat, double dropLong, String markerName) async {
    try {
      routeCoordinates.clear();
      final apiKey = AppUrl.googleApiKey;
      var location = await LocationService.getLocation();
      PointLatLng origin = PointLatLng(location.latitude!, location.longitude!);
      PointLatLng destination = PointLatLng(dropLat, dropLong);
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        apiKey, origin, destination, travelMode: TravelMode.driving, );
      log(result.points.toString());
      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          routeCoordinates.add(LatLng(point.latitude, point.longitude));
          markers =         Set<Marker>.from( <Marker>[
            Marker(
              markerId: MarkerId(markerName),
              icon: BitmapDescriptor.defaultMarker,
              position: LatLng(dropLat, dropLong), // Default to San Francisco
              infoWindow: InfoWindow(title: markerName),
            ),
          ]);
        });
        update();
      }
    }
    catch (e) {
      print(e.toString());
    }
  }

}
