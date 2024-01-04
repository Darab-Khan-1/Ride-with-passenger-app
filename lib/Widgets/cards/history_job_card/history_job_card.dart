// import 'package:celient_project/res/colors/colors.dart';
// import 'package:celient_project/res/components/widgets/buttons/round_button_widget.dart';
// import 'package:celient_project/res/components/widgets/text/expanded_text.dart';
// import 'package:celient_project/view/history_detail/history_detail_view.dart';
// import 'package:celient_project/view_model/controller/card/card_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class HistoryJobCards extends StatelessWidget {
//   final String date;
//   final String day;
//   final String month;
//   final String orderNo;
//   final String price;
//   final String pickupAddress;
//   final String pickupName;
//   final String deliverName;
//   final String deliverAddress;
//   final String time;
//   final String weight;
//   final String distance;
//   final String type;
//   final String piece;
//   final String deliverDate;
//   final String deliverDay;
//   final String deliverMonth;
//   final String deliverTime;
//   final String podImage;
//   final String unloadingImage;
//   final CardController _cardController = Get.put(CardController());
//   HistoryJobCards({
//     Key? key,
//     required this.date,
//     required this.day,
//     required this.month,
//     required this.orderNo,
//     required this.price,
//     required this.pickupAddress,
//     required this.deliverAddress,
//     required this.time,
//     required this.weight,
//     required this.distance,
//     required this.type,
//     required this.piece,
//     required this.deliverDate,
//     required this.deliverDay,
//     required this.deliverMonth,
//     required this.deliverTime,
//     required this.pickupName,
//     required this.deliverName,
//     required this.podImage,
//     required this.unloadingImage,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GestureDetector(
//           onDoubleTap: () {
//             Get.to(() => HistoryDetailView(
//                   pickupName: pickupName,
//                   pickupAddress: pickupAddress,
//                   pickupDateTime: time,
//                   piece: piece,
//                   dims: "",
//                   weight: weight,
//                   deliveryName: deliverName,
//                   deliveryAddress: deliverAddress,
//                   deliveryTime: deliverTime,
//                   orderNo: orderNo,
//                   price: price,
//                   date: date,
//                   day: day,
//                   month: month,
//                   deliverDate: deliverDate,
//                   deliverDay: deliverDay,
//                   deliverMonth: deliverMonth,
//                   podImage: podImage,
//                   unloadingImage: unloadingImage,
//                 ));
//           },
//           child: Container(
//             height: 300,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.shade300,
//                   blurRadius: 3.0,
//                   spreadRadius: 3.0,
//                   offset: const Offset(
//                     1.0,
//                     1.0,
//                   ),
//                 ),
//               ],
//               borderRadius: const BorderRadius.all(Radius.circular(20)),
//               color: AppColor.whiteColor,
//             ),
//             child: Visibility(
//               visible: _cardController.isExpanded.value,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 110,
//                       height: 300,
//                       decoration: const BoxDecoration(
//                         color: AppColor.blueColorShade800,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               date,
//                               style: const TextStyle(
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColor.whiteColor,
//                                 fontSize: 24,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               day,
//                               style: const TextStyle(
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.whiteColor,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 4,
//                               color: AppColor.whiteColor,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               month,
//                               style: const TextStyle(
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.whiteColor,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 4,
//                               color: AppColor.whiteColor,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: SingleChildScrollView(
//                         physics: const ScrollPhysics(),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   orderNo,
//                                   style: const TextStyle(
//                                     color: AppColor.appBarColor,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 24,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 100,
//                                 ),
//                                 const Icon(
//                                   MdiIcons.currencyUsd,
//                                   size: 25,
//                                   color: AppColor.appBarColor,
//                                 ),
//                                 Text(
//                                   price,
//                                   style: const TextStyle(
//                                     color: AppColor.appBarColor,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Text(
//                               'Pick-up point',
//                               style: TextStyle(
//                                 fontStyle: FontStyle.normal,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.greyColor,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             const Divider(
//                               color: AppColor.greyColor,
//                               thickness: 2,
//                               // Add this line
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width *
//                                   0.6, // Change this value as needed
//                               child: ExpandableText(
//                                 text: pickupAddress,
//                                 style: const TextStyle(
//                                   color: AppColor.appBarColor,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             const Text(
//                               'Delivery Point',
//                               style: TextStyle(
//                                 fontStyle: FontStyle.normal,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColor.greyColor,
//                                 fontSize: 17,
//                               ),
//                             ),
//                             const Divider(
//                               color: AppColor.greyColor,
//                               thickness: 2,
//                               // Add this line
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width *
//                                   0.6, // Change this value as needed
//                               child: ExpandableText(
//                                 text: deliverAddress,
//                                 style: const TextStyle(
//                                   color: AppColor.appBarColor,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 40,
//                             ),
//                             IntrinsicHeight(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   infoColumn("Time", time),
//                                   const VerticalDivider(
//                                     color: AppColor.greyColor,
//                                   ),
//                                   infoColumn("Weight", "$weight kg"),
//                                   const VerticalDivider(
//                                     color: AppColor.greyColor,
//                                   ),
//                                   infoColumn("Distance", "$distance Miles"),
//                                   const VerticalDivider(
//                                     color: AppColor.greyColor,
//                                   ),
//                                   infoColumn("Type", "$type"),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
//
// Widget infoColumn(String title, String data) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: AppColor.appBarColor,
//         ),
//       ),
//       Text(
//         data,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           color: AppColor.infoTextColor,
//         ),
//       ),
//     ],
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Widgets/dialog/custom_alert_dialog.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/constants/colors.dart';
import 'package:gap/gap.dart';
import '../../../controller/card_controller/card_controller.dart';
import '../../form_fields/expandable_text.dart';
class HistoryJobCards extends StatelessWidget {
  final String pickUpTime;
  final String deliverTime;
  final String pickUpdate;
  final String? amount;
  String? pickupZip;
  String? deliveryZip;
  final String pickUpday;
  final String pickUpmonth;
  final String loadId;
  final String price;
  final String pickupAddress;
  final String deliverAddress;
  final String dimension;
  final String weight;
  final String distance;
  final String? type;
  final String piece;
  final String? stackable;
  final String? hazardous;
  final String? dockLevel;
  final String deliveryDay;
  final String deliveryDate;
  final String deliveryYear;
  final String note;
  final CardController _cardController = Get.put(CardController());
  HistoryJobCards({
    Key? key,
    this.pickupZip,
    this.deliveryZip,
    this.amount,
    required this.pickUpTime,
    required this.deliverTime,
    required this.pickUpdate,
    required this.pickUpday,
    required this.pickUpmonth,
    required this.loadId,
    required this.price,
    required this.pickupAddress,
    required this.deliverAddress,
    required this.weight,
    required this.distance,
    required this.type,
    required this.piece,
    required this.deliveryDay,
    required this.deliveryDate,
    required this.deliveryYear,
    required this.dimension,
    required this.stackable,
    required this.hazardous,
    required this.dockLevel,
    required this.note,
  }) : super(key: key);
  final List<String> locations = [
    'Location A',
    'Location B',
    'Location C',
    // Add more locations as needed
  ];
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
                    loadId,
                    style: const TextStyle(
                      color: kMainColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Amount: ${amount ?? ""}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
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
                      // launchUrlString(
                      //     'https://www.google.com/maps/search/?api=1&query=$dropLat,$dropLng');
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
                      KText(text: "Hammad", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                      Gap(10),
                      KText(text: "Travel Time", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: "20 min", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                    ],
                  ),
                  Column(
                    children: [
                      KText(text: "Customer Phone", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: "0300-1234567", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                      Gap(10),
                      KText(text: "Miles", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                      KText(text: "20 ", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  KText(text: "Stops: ", color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500,),
                  SizedBox(width: 10,),
                  KText(text: "1", color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w500,),
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
                              for (String location in locations)
                                ListTile(
                                  title: Text(location),
                                  focusColor: kMainColor,
                                  // Customize the design of each list item here
                                  // For example, you can add icons, different text styles, etc.
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
