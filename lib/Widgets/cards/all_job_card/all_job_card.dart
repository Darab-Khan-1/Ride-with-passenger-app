

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';
import '../../../constants/colors.dart';
import '../../../controller/all_job_controller/all_job_controller.dart';
import '../../../controller/card_controller/card_controller.dart';
import '../../../model/all_trip_model/all_trip_model.dart';
import '../../dialog/custom_alert_dialog.dart';
import '../../form_fields/expandable_text.dart';
import '../../form_fields/k_text.dart';
import 'package:intl/intl.dart';

import 'job_status_card.dart';

class AllJobCards extends StatelessWidget {
  final String pickUpDate;
  final String estimatedTime;
  final String deliverDate;
  final String pickUpdate;
  String? pickupZip;
  String? deliveryZip;
  final String pickUpday;
  final String pickUpmonth;
  final String loadId;
  final String pickupAddress;
  final String deliverAddress;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropLat;
  final double? dropLng;
  final int? tripId;
  final String distance;
   List<AllTripStops> allTripStops ;
  final CardController _cardController = Get.put(CardController());
  AllJobCards({
    Key? key,
    this.pickupZip,
    this.deliveryZip,
    required this.estimatedTime,
    required this.tripId,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropLat,
    required this.dropLng,
    required this.pickUpDate,
    required this.deliverDate,
    required this.pickUpdate,
    required this.pickUpday,
    required this.pickUpmonth,
    required this.loadId,
    required this.pickupAddress,
    required this.deliverAddress,
    required this.distance,
    required this.allTripStops,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Card(
        margin: const EdgeInsets.all(8.0),
        // color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              // color: Colors.white,
              // decoration: BoxDecoration(
              //   boxShadow: [
              //     BoxShadow(
              //       color: Colors.grey.shade300,
              //       blurRadius: 3.0,
              //       spreadRadius: 3.0,
              //       offset: const Offset(1.0, 1.0),
              //     ),
              //   ],
              //   borderRadius: const BorderRadius.all(Radius.circular(20)),
              //   color: kWhiteColor,
              // ),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Visibility(
                        visible: _cardController.isExpanded.value,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                              color: kMainColor,
                          ),
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( pickUpmonth, style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),),
                              Divider(
                                color: kWhiteColor,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Text( pickUpdate, style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),),
                              Divider(
                                color: kWhiteColor,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Text( pickUpday, style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),),
                              Divider(
                                color: kWhiteColor,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                               Text(DateFormat('y').format(DateTime.parse(pickUpDate)),
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                              ),)

                            ],
                          ),
                  ),
                      )),
                  Expanded(
                    flex: 5,
                    child: Visibility(
                      visible: _cardController.isExpanded.value,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  loadId,
                                  style: const TextStyle(
                                    color: kBlackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        HomeScreenController().startTrip(tripId!);
                                        },
                                        child: Container(
                                          width: 80,
                                          alignment: Alignment.center,
                                          decoration: new BoxDecoration(
                                              color: Colors.green.shade300,
                                              borderRadius: new BorderRadius.all(Radius.circular(5))),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                "Start",
                                                style: TextStyle(
                                                    color: kWhiteColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )),
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            const Text(
                              'Pick-up point',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: kGreenColor,
                                fontSize: 15,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text:
                                    pickupAddress + ", " + (pickupZip ?? ""),
                                    style: const TextStyle(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: pickUpDate,
                                    style: const TextStyle(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Delivery Point',
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                color: kGreenColor,
                                fontSize: 14,
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: deliverAddress +
                                        ", " +
                                        (deliveryZip ?? ""),
                                    style: const TextStyle(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6, // Change this value as needed
                                  child: ExpandableText(
                                    text: deliverDate,
                                    style: const TextStyle(
                                      color: kBlackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                      children: [
                                        infoColumn("Estimated Time", estimatedTime),
                                      ]),
                                  const VerticalDivider(
                                    color: kGreyColor,
                                  ),
                                  Column(
                                      children:
                                      [
                                        infoColumn("Distance", distance),
                                      ]),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            allTripStops.isEmpty?Container():
                            Row(
                              children: [
                                KText(text: "Stops: ", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                                SizedBox(width: 10,),
                                KText(text: "${allTripStops.length}", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                                Expanded(child: Container()),
                                OutlinedButton(child: KText(text: 'Details', color: kMainColor,fontSize: 16), onPressed: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return CustomAlertDialog(
                                          title: "Trip Stops",
                                          content: Container(
                                            width: size.width,
                                            height: size.height * 0.3,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                      itemCount: allTripStops.length,
                                                      itemBuilder: (context, index){
                                                        var stop = allTripStops[index];
                                                        return ListTile(
                                                          leading: CircleAvatar(
                                                            backgroundColor: kMainColor.withOpacity(0.3),
                                                            child: Text("${index+1}"),
                                                          ),
                                                          title: Text(stop.location!),
                                                          focusColor: kMainColor,
                                                          // Customize the design of each list item here
                                                          // For example, you can add icons, different text styles, etc.
                                                        );
                                                      }),
                                                ),

                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                  ) ;
                                },

                                )

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget infoColumn(String title, String? data) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: kBlackColor,
        ),
      ),
      Text(
        data ?? "",
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    ],
  );
}

