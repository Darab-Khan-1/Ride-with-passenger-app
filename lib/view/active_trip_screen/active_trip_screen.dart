import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_with_passenger/Widgets/cards/all_job_card/all_job_card.dart';
import 'package:ride_with_passenger/Widgets/cards/current_trip_card/active_trip_card.dart';
import 'package:ride_with_passenger/controller/all_job_controller/all_job_controller.dart';

import '../../Widgets/form_fields/k_text.dart';
import '../../constants/enums.dart';
import '../../controller/trip_controller/trip_controller.dart';

class ActiveTripScreen extends StatelessWidget {
   ActiveTripScreen({super.key});
final controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Trip"),
      ),
      body:  Container(
        width: Get.width,
        height: Get.height,
        child: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet') {
                return Column(children: [
                  KText(text: "No Internet"),
                  ElevatedButton(onPressed: (){
                    controller.tripsCircleApi();
                  }, child: KText(text: "Retry",))
                ],);
              } else {
                return Center(
                  child: Column(children: [
                    KText(text: "Something went wrong"),
                    ElevatedButton(onPressed: (){
                      controller.tripsCircleApi();
                    }, child: KText(text: "Retry",))
                  ],),
                );
              }
            case Status.COMPLETED:
              if(controller.ongoingTrip.value.data != null ) {
                return Container(
                  height: Get.height * 0.3,
                  width: Get.width * 0.9,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var data = controller.ongoingTrip.value.data!;
                      return ActiveTripCard(
                        pickupLat: double.parse(data.lat!),
                        pickupLng: double.parse(data.long!),
                        dropLat: double.parse(data.dropLat!),
                        dropLng: double.parse(data.dropLong!),
                        pickUpDate: DateFormat('yyyy-MM-dd').format(DateTime.parse(data.pickupDate!)),
                        deliverDate: DateFormat('yyyy-MM-dd').format(DateTime.parse(data.deliveryDate!)),
                        pickUpmonth: DateFormat('MMM').format(DateTime.parse(data.pickupDate!)),
                        pickUpdate: DateFormat('d').format(DateTime.parse(data.pickupDate!)),
                        pickUpday: DateFormat('EEE').format(DateTime.parse(data.pickupDate!)),
                        loadId: data.id.toString(),
                        status: data.status!,
                        nextStop: data.nextStop!,
                        currentStop: data.currentStop!,
                        estimatedTime: data.estimatedTime!,
                        pickupAddress: data.pickupLocation!,
                        deliverAddress: data.deliveryLocation!,
                        distance: data.estimatedDistance!,
                        allTripStops: data.stops!,
                        tripId: data.id!,
                        shareUrl: data.url!,
                      );
                    },
                  ),
                  //   ),
                );
              }
              return Container();
          }

        }),
      ),
    );
  }
}
