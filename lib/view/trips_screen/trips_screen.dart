import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';

import '../../Widgets/cards/all_job_card/all_job_card.dart';
import '../../constants/colors.dart';
import '../../controller/all_job_controller/all_job_controller.dart';

class TripsScreen extends StatefulWidget {
  TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  DateTime? parsedDate;

  DateTime? parsePickUpDate;

  final controller = Get.put(TripController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAlltrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trips"),
      ),
      body: Obx(() => Container(
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
          controller: controller.refreshHomeController,
          onRefresh: () {
            controller.getAlltrips();
            controller.refreshHomeController.refreshCompleted();
          },
          child: controller.allTrips.value.data!.length == 0
              ? Center(
            child: Text("No Trips"),
          )
              : ListView.builder(
              itemCount: controller.allTrips.value.data!.length,
              itemBuilder:
                  (BuildContext context, int index) {
                var data = controller.allTrips.value.data![index];
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
                );
              }),
        ),
      )),
    );
  }
}
