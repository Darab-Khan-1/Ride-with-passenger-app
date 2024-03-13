import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';

import '../../Widgets/cards/all_job_card/all_job_card.dart';
import '../../constants/colors.dart';
import '../../controller/all_job_controller/all_job_controller.dart';

class MyTripsScreen extends StatefulWidget {
  MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  DateTime? parsedDate;

  DateTime? parsePickUpDate;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripController>(
      init: TripController(),
        builder: (controller) {
      return Obx(() => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: controller.isloading.value
            ? Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        )
            :
        SmartRefresher(
          enablePullDown: true,
          controller: controller.refreshMyTripsController,
          onRefresh: () {
            controller.getAllMyTrips();
            controller.refreshMyTripsController.refreshCompleted();
          },
          child: controller.myTrips.value.data == null
              ? const Center(
            child: Text("No Trips"),
          )
              : ListView.builder(
              itemCount: controller.myTrips.value.data!.length,
              itemBuilder:
                  (BuildContext context, int index) {
                var data = controller.myTrips.value.data![index];
                String pickUpDateString = data.pickupDate!;
                if (pickUpDateString != "") {
                  try {
                    parsePickUpDate =
                        DateFormat("yyyy-MM-dd")
                            .parse(pickUpDateString);
                  } catch (e) {
                    print('Failed to parse date: $e');
                  }
                }

                return AllJobCards(
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
                  estimatedTime: data.estimatedTime!,
                  pickupAddress: data.pickupLocation!,
                  deliverAddress: data.deliveryLocation!,
                  distance: data.estimatedDistance!,
                  allTripStops: data.stops!,
                  tripId: data.id!,
                  isEnable: true,
                );
              }),
        ),
      ));
    });
  }
}
