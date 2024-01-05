import 'dart:async';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/enums.dart';
class AllJobViewModel extends GetxController {
  // LatLng? currentLocation;
  RefreshController refreshAllJobController = RefreshController();
  // final currentVM = Get.put(CurrentTripController());
  // RxString price = '0'.obs;
  // RxInt miles = 160.obs;
  //  updatePrice(String newPrice) {
  //   price.value = newPrice;
  // }
  @override
  void onInit() {
    super.onInit();
    // getLoads();
  }
  RxBool isloading = false.obs;
  // String updatePrice(String newPrice) {
  //   price.value = newPrice;
  //   return price.value;
  // }


  late DateTime now;
  late int daysInMonth;
  late DateTime day;



  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  // RxDouble postalCodeLat = 0.0.obs;
  // RxDouble postalCodeLong = 0.0.obs;
  // RxString estimationTime = ''.obs;
  //
  // /// =================== Date Selection ================== ///
  // Rx<DateTime?> selectedDate = Rx<DateTime?>(DateTime.now());
  // RxBool isAllLoads = false.obs;
  // int offset = 0;

  // void selectDate(DateTime date) {
  //   if (selectedDate.value != date) {
  //     selectedDate.value = date;
  //     // Notify listeners to rebuild the view and clear the previous data
  //     setRxRequestStatus(Status.LOADING); // Set the loading status
  //     Future.delayed(Duration(milliseconds: 100), () {
  //       update(); // Make a network call when a date is selected
  //     });
  //   }
  // }


  // bool get isDateSelected => selectedDate.value != null;
  // String? get selectedMonth {
  //   if (isDateSelected) {
  //     return DateFormat('MMMM').format(selectedDate.value!);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // String? get selectedDayDate {
  //   if (isDateSelected) {
  //     return selectedDate.value!.day.toString();
  //   } else {
  //     return null;
  //   }
  // }
  //
  // String? get selectedYear {
  //   if (isDateSelected) {
  //     return selectedDate.value!.year.toString();
  //   } else {
  //     return null;
  //   }
  // }
  //
  // String? get selectedDay {
  //   if (isDateSelected) {
  //     // Use 'EEEE' format to get day of the week
  //     return DateFormat('EEEE').format(selectedDate.value!);
  //   } else {
  //     return null;
  //   }
  // }

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
  ScrollController scrollController = ScrollController();
  RxBool isLoadingNextOffset = false.obs; // add this variable
  void addScrollListener() {
    scrollController.addListener(() {
      // Load more when scrolled to the bottom
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          hasMoreData.value) {
        hasMoreData.value = false;
        // offset += 1;
      }
      // Load previous when scrolled to the top
      // else if (scrollController.position.pixels ==
      //         scrollController.position.minScrollExtent &&
      //     offset > 0) {
      //   offset -= 1;
      //   refreshApi();
      // }
    });
  }
  RxBool hasMoreData = false.obs;

  // final _api = AllJobRepository();
  // final driverLoadModel = DriverLoadModel().obs;

  // Future<void> getLoads() async {
  //   setRxRequestStatus(Status.LOADING);
  //   isloading.value = true;
  //   _api.getAllJobsApi().then((value) async {
  //     if (value.statusCode == 200) {
  //       appendLoadsList(value, true);
  //       isLoadingNextOffset.value = false;
  //       update();
  //       isloading.value = false;
  //     } else {
  //       Get.snackbar('Error', value.message!);
  //       isloading.value = false;
  //     }
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  //
  // }

  // Future<void> appendLoadsList(DriverLoadModel value, bool clear) async {
  //   List<Data>? list =[];
  //   list = value.data;
  //   if (clear) {
  //     driverLoadModel.value.data = [];
  //   }
  //   // list?.sort((a, b) {
  //   //   return (a.id ?? 0).compareTo(b.id ?? 0);
  //   // });
  //   driverLoadModel.value.data!.addAll(list!);
  //   update();
  // }
  // Future<void> startTrip(String id) async{
  //   isloading.value = true;
  //   Map<String, dynamic> data = {
  //     "id": id,
  //   };
  //   _api.startTripApi(data).then((value) async {
  //     if (value["status_code"] == 200) {
  //       Get.snackbar('Success', "Trip Started Successfully");
  //       isloading.value = false;
  //       if(driverLoadModel.value.data!.length > 0){
  //         for(int i = 0; i < driverLoadModel.value.data!.length; i++){
  //           if(driverLoadModel.value.data![i].id == id){
  //             driverLoadModel.value.data![i].status = "started";
  //             update();
  //             break;
  //           }
  //         }
  //       }
  //       currentVM.onGoingTrip();
  //       getLoads();
  //     } else {
  //       Get.snackbar('Error', value["error"]);
  //       isloading.value = false;
  //     }
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  // Future<void> pickupTrip(String id) async{
  //   isloading.value = true;
  //   Map<String, dynamic> data = {
  //     "id": id,
  //   };
  //   _api.pickupTrip(data).then((value) async {
  //     if (value['status_code'] == 200) {
  //       Utils.snackBar('Success', value["message"]);
  //       isloading.value = false;
  //       if(driverLoadModel.value.data!.length > 0){
  //         for(int i = 0; i < driverLoadModel.value.data!.length; i++){
  //           if(driverLoadModel.value.data![i].id == id){
  //             driverLoadModel.value.data![i].status = "in_transit";
  //             update();
  //             break;
  //           }
  //         }
  //       }
  //       currentVM.onGoingTrip();
  //       getLoads();
  //       update();
  //     } else {
  //       Utils.snackBar('Error', value['error']);
  //       isloading.value = false;
  //     }
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  // Future<void> completeTrip(String id) async{
  //   isloading.value = true;
  //   Map<String, dynamic> data = {
  //     "id": id,
  //   };
  //   _api.completeTrip(data).then((value) async {
  //     if (value['status_code'] == 200) {
  //       Utils.snackBar('Success', value['message']);
  //       isloading.value = false;
  //       if(driverLoadModel.value.data!.length > 0){
  //         for(int i = 0; i < driverLoadModel.value.data!.length; i++){
  //           if(driverLoadModel.value.data![i].id == id){
  //             driverLoadModel.value.data![i].status = "completed";
  //             update();
  //             break;
  //           }
  //         }
  //       }
  //       getLoads();
  //       currentVM.onGoingTrip();
  //       update();
  //     } else {
  //       Utils.snackBar('Error', value['error']);
  //       isloading.value = false;
  //     }
  //   }).onError((error, stackTrace) {
  //     isloading.value = false;
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  //
  // refreshApi() async {
  //   setRxRequestStatus(Status.LOADING);
  //   _api.getAllJobsApi().then((value) async {
  //     if (value.statusCode == 200) {
  //       appendLoadsList(value, true);
  //       isLoadingNextOffset.value = false;
  //       update();
  //     } else {
  //       Get.snackbar('Error', value.message!);
  //     }
  //   }).onError((error, stackTrace) {
  //     setError(error.toString());
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
}
