import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  final controller = Get.put(AllJobViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.getLoads();
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
          controller: controller.refreshAllJobController,
          onRefresh: () {
            // controller.getLoads();
            controller.refreshAllJobController.refreshCompleted();
          },
          child: ListView.builder(
              itemCount: 1,
              itemBuilder:
                  (BuildContext context, int index) {
                // var data = controller.driverLoadModel
                //     .value.data![index];
                // String pickUpDateString = controller
                //     .driverLoadModel
                //     .value
                //     .data![index]
                //     .pickupDate
                //     .toString();
                // if (pickUpDateString != "ASAP") {
                //   try {
                //     parsePickUpDate =
                //         DateFormat("yyyy-MM-dd")
                //             .parse(pickUpDateString);
                //   } catch (e) {
                //     print('Failed to parse date: $e');
                //   }
                // }

                return AllJobCards(
                  pickupLat: 34.56723,
                  pickupLng: 74.53232,
                  dropLat: 35.678587,
                  dropLng: 74.45345,
                  pickUpTime: ["12:00", "12:30",],
                  pickUpDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  deliverDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  deliveryTime: ["12:00", "12:30",],
                  pickUpmonth: DateFormat('MMM')
                      .format(DateTime.now()),
                  pickUpdate: DateFormat('d')
                      .format(DateTime.now()),
                  pickUpday: DateFormat('EEE')
                      .format(DateTime.now()),
                  loadId: "1",
                  estimatedTime: "12:00",
                  pickupAddress: "Srinagar",
                  deliverAddress: "Jammu",
                  weight: "100",
                  distance: "100",
                  type: "Truck",
                  status: "available",
                  deliveryDay: "Wednesday",
                  deliveryDate: DateTime.now().toString(),
                  deliveryYear: "2023",
                  note: "Notes",
                );
              }),
        ),
      )),
    );
  }
}
