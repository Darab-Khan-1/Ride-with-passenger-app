
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_with_passenger/Widgets/dialog/custom_alert_dialog.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/constants/colors.dart';
import 'package:gap/gap.dart';
import 'package:ride_with_passenger/model/trip_history_model/trip_history_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../controller/card_controller/card_controller.dart';
import '../../form_fields/expandable_text.dart';
class HistoryJobCards extends StatelessWidget {
  final String pickUpTime;
  final String deliverTime;
  final String pickUpdate;
  String? pickupZip;
  final double dropLat;
  final double dropLng;
  final double pickLat;
  final double pickLng;
  final List<TripHistoryStops> stops;
  String? deliveryZip;
  final String pickUpday;
  final String pickUpmonth;
  final String loadId;
  final String pickupAddress;
  final String deliverAddress;
  final String deliveryDay;
  final String deliveryDate;
  final String deliveryYear;
  final String customerName;
  final String customerPhone;
  final String travelTime;
  final String miles;

  final CardController _cardController = Get.put(CardController());
  HistoryJobCards({
    Key? key,
    this.pickupZip,
    this.deliveryZip,
    required this.pickUpTime,
    required this.deliverTime,
    required this.pickUpdate,
    required this.pickUpday,
    required this.pickUpmonth,
    required this.loadId,
    required this.pickupAddress,
    required this.deliverAddress,
    required this.deliveryDay,
    required this.deliveryDate,
    required this.deliveryYear,
    required this.stops,
    required this.dropLat,
    required this.dropLng,
    required this.pickLat,
    required this.pickLng,
    required this.customerName,
    required this.customerPhone,
    required this.travelTime,
    required this.miles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        // height: 415,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: const Offset(1.0, 1.0),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trip Id: $loadId",
                    style: const TextStyle(
                      color: kMainColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Amount: ${amount ?? ""}",
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              KText(text: "Pick-up", color: kMainColor, fontSize: 14, fontWeight: FontWeight.w500,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          text: pickUpTime,
                          style: const TextStyle(
                            color: kBlackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      launchUrlString(
                          'https://www.google.com/maps/search/?api=1&query=$pickLat,$pickLng');
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.directions,
                        ),
                        Text("Directions")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              KText(text: "Delivery", color: kMainColor, fontSize: 14, fontWeight: FontWeight.w500,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        child: ExpandableText(
                          text: deliverTime,
                          style: const TextStyle(
                            color: kBlackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      launchUrlString(
                          'https://www.google.com/maps/search/?api=1&query=$dropLat,$dropLng');
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.directions,
                        ),
                        Text("Directions")
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      KText(text: "Customer Name", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: customerName, color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                      Gap(10),
                      KText(text: "Travel Time", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: travelTime, color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                    ],
                  ),
                  Column(
                    children: [
                      KText(text: "Customer Phone", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: customerPhone, color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                      Gap(10),
                      KText(text: "Estimated Distance", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: miles, color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              stops.isEmpty ? Container() :
              Row(
                children: [
                  KText(text: "Stops: ", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                  SizedBox(width: 10,),
                  KText(text: "${stops.length}", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                  Expanded(child: Container()),
                  OutlinedButton(child: KText(text: 'Details', color: kMainColor,fontSize: 16), onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return CustomAlertDialog(
                            title: "Stops Details",
                            content: Container(
                              width: size.width,
                              height: size.height * 0.3,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: stops.length,
                                        itemBuilder: (context, index){
                                          var stop = stops[index];
                                          return ListTile(
                                            leading: CircleAvatar(
                                              radius: 15,
                                              backgroundColor: kMainColor.withOpacity(0.3),
                                              child: Text("${index+1}"),
                                            ),
                                            title: Text(stop.location!),
                                            subtitle: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Enter: ", style: TextStyle(color: kMainColor, fontWeight: FontWeight.bold),),
                                                    Text("${ DateFormat("HH mm").format(DateTime.parse(stop.datetime!))}"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(" - Exit: ", style: TextStyle(color: kMainColor, fontWeight: FontWeight.bold),),
                                                    Text("${ DateFormat("HH mm").format(DateTime.parse(stop.exitTime!))}"),
                                                  ],
                                                ),
                                              ],
                                            ),
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
      )
    );
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
          color: kMainColor,
        ),
      ),
      Text(
        data ?? "",
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: kBlackColor,
        ),
      ),
    ],
  );
}
