
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ride_with_passenger/model/all_trip_model/all_trip_model.dart';
import 'package:ride_with_passenger/model/trip_history_model/trip_history_model.dart';

import '../../Services/user_preferences/user_preferences.dart';
import '../../constants/app_url/app_url.dart';
import '../../constants/enums.dart';
import '../../data/network/network_api_services.dart';
import '../../utils/utils.dart';
import '../../view/splash_screen/splash_screen.dart';

class HistoryController extends GetxController {
  RefreshController refreshPendingTripsController = RefreshController();
  final rxRequestStatus = Status.COMPLETED.obs;
  final historyList = TripHistoryModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  // void setUserList(CompletedTripModel _value) => tripsList.value = _value;
  void setError(String _value) => error.value = _value;
  final _apiService = NetworkApiServices();
  UserPreference userPreference = UserPreference();
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    completedTrips();
  }

  Future<dynamic> completedTrips() async{

    try {
      setRxRequestStatus(Status.LOADING);
      dynamic response = await _apiService.getApi(AppUrl.completedTrips);
      if(response['status_code'] == 200){
        setRxRequestStatus(Status.COMPLETED);
        historyList.value = TripHistoryModel.fromJson(response);
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
}
