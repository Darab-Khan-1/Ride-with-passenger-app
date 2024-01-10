import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';

import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../controller/all_job_controller/all_job_controller.dart';
StatelessWidget loadStatus(
    String status, BuildContext context) {
  final controller = Get.put(TripController());
  return Container(
    width: 80,
    alignment: Alignment.center,
    decoration: new BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: new BorderRadius.all(Radius.circular(5))),
    child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          status,
          style: TextStyle(
              color: kWhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        )),
  );
}

// Widget tripButton() {
//   if (model.status == 'started') {
//     return OutlinedButton(onPressed: () {
//
//     },
//         child: KText(text: "Ready", color: kMainColor, fontSize: 18));
//   }
//   else if (model.status == 'pickup') {
//     return OutlinedButton(onPressed: () {},
//         child: KText(text: "Start", color: kMainColor, fontSize: 18));
//   }
//   else if (model.status == 'in-transit') {
//     return OutlinedButton(onPressed: () {},
//         child: KText(text: "Stop", color: kMainColor, fontSize: 18));
//   } else {
//     return Container();
//   }
// }