import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:location/location.dart';
import 'package:ride_with_passenger/model/on_going_trip_model/ongoing_trip_model.dart';

import '../../constants/enums.dart';

class TripController extends GetxController{
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
  RefreshController refreshHomeController = RefreshController();
  final ongoingTrip = OnGoingTripModel().obs;
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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
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

}