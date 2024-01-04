
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/enums.dart';

class HistoryController extends GetxController {
  RefreshController refreshPendingTripsController = RefreshController();
  final rxRequestStatus = Status.COMPLETED.obs;
  // final tripsList = CompletedTripModel().obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  // void setUserList(CompletedTripModel _value) => tripsList.value = _value;
  void setError(String _value) => error.value = _value;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // historyListApi();
  }
  // void historyListApi() {
  //   _api.getHistory().then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     setUserList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }

  // refreshApi() {
  //   setRxRequestStatus(Status.LOADING);
  //   _api.getHistory().then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     setUserList(value);
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
}
