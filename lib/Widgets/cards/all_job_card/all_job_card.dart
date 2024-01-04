

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../controller/card_controller/card_controller.dart';
import '../../form_fields/expandable_text.dart';
import '../../form_fields/k_text.dart';
import 'package:intl/intl.dart';

import 'job_status_card.dart';

class AllJobCards extends StatelessWidget {
  final String pickUpDate;
  final String estimatedTime;
  final String deliverDate;
  final String pickUpdate;
  final List<String> pickUpTime;
  final List<String> deliveryTime;
  String? pickupZip;
  String? deliveryZip;
  final String pickUpday;
  final String pickUpmonth;
  final String loadId;
  final String status;
  final String pickupAddress;
  final String deliverAddress;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropLat;
  final double? dropLng;
  final String weight;
  final String distance;
  final String? type;
  final String deliveryDay;
  final String deliveryDate;
  final String deliveryYear;
  final String note;
  final CardController _cardController = Get.put(CardController());
  AllJobCards({
    Key? key,
    this.pickupZip,
    required this.pickUpTime,
    required this.deliveryTime,
    this.deliveryZip,
    required this.estimatedTime,
    required this.status,
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
    required this.weight,
    required this.distance,
    required this.type,
    required this.deliveryDay,
    required this.deliveryDate,
    required this.deliveryYear,
    required this.note,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                          height: 280,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    loadStatus(status, DateTime.parse(pickUpDate),loadId,  context),
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
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: Row(
                                    children: [
                                      ExpandableText(
                                        text: pickUpDate,
                                        style: const TextStyle(
                                          color: kBlackColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      pickUpTime.length == 1 ? KText(text: pickUpTime.first) :
                                          KText(text: pickUpTime.first + " - " + pickUpTime.last),
                                    ],
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
                                  width: MediaQuery.of(context).size.width *
                                      0.6, // Change this value as needed
                                  child: Row(
                                    children: [
                                      ExpandableText(
                                        text: deliverDate,
                                        style: const TextStyle(
                                          color: kBlackColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      deliveryTime.length == 1 ? KText(text: deliveryTime.first) :
                                      KText(text: deliveryTime.first + " - " + deliveryTime.last),
                                    ],
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
                                        SizedBox(height: 10,),
                                        infoColumn("Type", type),
                                      ]),
                                  const VerticalDivider(
                                    color: kGreyColor,
                                  ),
                                  Column(
                                      children:
                                      [
                                        infoColumn("Distance", distance),
                                        SizedBox(height: 10,),
                                        infoColumn("Weight", weight),
                                      ]),
                                ],
                              ),
                            ),
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

