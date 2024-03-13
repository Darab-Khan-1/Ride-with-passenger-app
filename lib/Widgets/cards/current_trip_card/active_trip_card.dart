

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text_field.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';
import 'package:ride_with_passenger/model/on_going_trip_model/ongoing_trip_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/colors.dart';
import '../../../constants/enums.dart';
import '../../../controller/all_job_controller/all_job_controller.dart';
import '../../../controller/card_controller/card_controller.dart';
import '../../../model/all_trip_model/all_trip_model.dart';
import '../../dialog/custom_alert_dialog.dart';
import '../../form_fields/expandable_text.dart';
import '../../form_fields/k_text.dart';
import 'package:intl/intl.dart';

class ActiveTripCard extends StatelessWidget {
  final String pickUpDate;
  final String estimatedTime;
  final String deliverDate;
  final String pickUpdate;
  final String? pickupZip;
  final String? deliveryZip;
  final String? status;
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
  final int? currentStop;
  final String distance;
  final String? shareUrl;
  final List<OnGoingTripStops> allTripStops ;
  final OnGoingTripNextStop? nextStop;
  final CardController _cardController = Get.put(CardController());
  ActiveTripCard({
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
    this.status, this.nextStop, this.currentStop, this.shareUrl,
  }) : super(key: key);
  final _homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Card(
        margin: const EdgeInsets.all(8.0),
        // color: Colors.transparent,
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
                    height: 300,
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: _cardController.isExpanded.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Share.shareWithResult(shareUrl ?? "",subject: "Current Trip");
                        },
                        child: const Align(
                          alignment: Alignment.topRight,
                            child: Text("Share Trip", style: TextStyle(color: kMainColor, fontSize: 16, fontWeight: FontWeight.w500),)),
                      ),
                      const Gap(5),
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
                          tripButton(context),
                          // Row(
                          //   children: [
                          //     GestureDetector(
                          //         onTap: () {
                          //           showDialog(
                          //               context: context,
                          //               barrierDismissible: false,
                          //               builder: (BuildContext context){
                          //                 return KAlertDialog(
                          //                   title: "Start Trip",
                          //                   content: "Are you sure you want to start this trip?",
                          //
                          //                   isCancel: true,
                          //                   isOk: true,
                          //                   okOnPressed: (){
                          //                     Navigator.pop(context);
                          //                     HomeScreenController().startTrip(tripId!);
                          //                   },
                          //                   cancelOnPressed: (){
                          //                     Navigator.pop(context);
                          //                   },
                          //
                          //                 );
                          //               }
                          //           ) ;
                          //
                          //         },
                          //         child: Container(
                          //           width: 80,
                          //           alignment: Alignment.center,
                          //           decoration: new BoxDecoration(
                          //               color: Colors.green.shade300,
                          //               borderRadius: new BorderRadius.all(Radius.circular(5))),
                          //           child: Padding(
                          //               padding: const EdgeInsets.all(4.0),
                          //               child: Text(
                          //                 "Start",
                          //                 style: TextStyle(
                          //                     color: kWhiteColor,
                          //                     fontSize: 16,
                          //                     fontWeight: FontWeight.bold
                          //                 ),
                          //               )),
                          //         )
                          //     ),
                          //   ],
                          // )
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
                      // allTripStops.length <= 2 ?Container():
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
                                                      backgroundColor: kMainColor.withOpacity(0.2),
                                                      radius: 15,
                                                      child: Text("${index}"),
                                                    ),
                                                    title: Text(stop.location!),
                                                    subtitle: ExpandableText(text: stop.description!,
                                                      style: const TextStyle(color: kBlackColor, fontWeight: FontWeight.w500),),
                                                    focusColor: kMainColor,
                                                    trailing: stop.datetime == null ? InkWell(
                                                      onTap: (){
                                                        showDialog(context: context, builder: (context){
                                                          return KAlertDialog(
                                                            title: "Delete Stop",
                                                            content: "Are you sure you want to delete this stop?",
                                                            isCancel: true,
                                                            isOk: true,
                                                            cancelOnPressed: (){
                                                              Get.back();
                                                            },
                                                            okOnPressed: () async {
                                                              Get.back();
                                                              Get.back();
                                                              _homeController.setRxRequestStatus(Status.LOADING);
                                                              await _homeController.deleteStop(tripId.toString(), stop.id.toString());
                                                              await _homeController.tripsCircleApi();
                                                              Future.delayed(Duration(seconds: 2));
                                                              _homeController.setRxRequestStatus(Status.COMPLETED);
                                                            },
                                                          );
                                                        });
                                                      },
                                                        child: const Icon(Icons.delete, color: kMainColor,)) : null,
                                                    // Customize the design of each list item here
                                                    // For example, you can add icons, different text styles, etc.
                                                  );
                                                }),
                                          ),

                                        ],
                                      ),
                                    ),
                                    isEnable: true,
                                  );
                                }
                            ) ;
                          },

                          )

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  Widget tripButton(BuildContext context) {
    try {
      if (status == 'started') {
        return OutlinedButton(onPressed: () async {
          showDialog(context: context, builder: (context){
            return KAlertDialog(
              title: "Arrived At Pickup",
              content: "Are you sure you reach the pickup point?",
              isCancel: true,
              isOk: true,
              cancelOnPressed: (){
                Get.back();
              },
              okOnPressed: () async {
                Get.back();
                _homeController.setRxRequestStatus(Status.LOADING);
                await HomeScreenController().pickupTrip(tripId!);
                await _homeController.tripsCircleApi();
                Future.delayed(Duration(seconds: 2));
                _homeController.setRxRequestStatus(Status.COMPLETED);
              },
            );
          });
        },
            child: KText(text: "Arrived", color: kMainColor, fontSize: 18));
      }
      else if (status == 'pickup') {
        return OutlinedButton(onPressed: () {
        },
            child: KText(text: "Start", color: kMainColor, fontSize: 18));
      }
      else if (status == 'stopped') {
        return OutlinedButton(onPressed: () async {
          showDialog(context: context, builder: (context){
            return KAlertDialog(
              title: "Exit Stop",
              content: "Are you sure to exit this stop?",
              isCancel: true,
              isOk: true,
              cancelOnPressed: (){
                Get.back();
              },
              okOnPressed: () async {
                Get.back();
                _homeController.setRxRequestStatus(Status.LOADING);
                await HomeScreenController().exitStop(tripId!, currentStop);
                await _homeController.tripsCircleApi();
                Future.delayed(Duration(seconds: 2));
                _homeController.setRxRequestStatus(Status.COMPLETED);
              },
            );
          });
        },
            child: KText(text: "Exit", color: kMainColor, fontSize: 18));
      }
      else if (status == 'in-transit') {
        if(nextStop!.type == "stop"){
          return OutlinedButton(onPressed: () async {
            var currentLocation = await _homeController.getAddress(context);
            showDialog(context: context, builder: (context){
              return stopTripDialog(
                title: "Arrived At Stop",
                content: SizedBox(
                  width: Get.width,
                  height: Get.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Are you sure you reach the stop point?"),
                      Text("Stop Location: ", style: const TextStyle(color: kMainColor, fontWeight: FontWeight.w500),),
                      Text(nextStop!.address!,),
                      Text("Current Location: ", style: const TextStyle(color: kMainColor, fontWeight: FontWeight.w500),),
                      Text(currentLocation),
                      Divider(),
                      const Text("Do you want change the stop location or countinue existing stop location?")


                    ],
                  ),
                ),
                cancelOnPressed: () async {
                  Map<String, dynamic> data = {
                    "trip_id": tripId.toString(),
                    "stop_id": nextStop!.stopId.toString(),
                    'lat': _homeController.currentPosition.value!.latitude.toString(),
                    'long': _homeController.currentPosition.value!.longitude.toString(),
                    'location': currentLocation,
                  };
                  Get.back();
                  _homeController.setRxRequestStatus(Status.LOADING);
                  await HomeScreenController().stopTrip(data);
                  await _homeController.tripsCircleApi();
                  Future.delayed(Duration(seconds: 2));
                  _homeController.setRxRequestStatus(Status.COMPLETED);
                },
                okOnPressed: () async {
                  Map<String, dynamic> data = {
                    "trip_id": tripId.toString(),
                    "stop_id": nextStop!.stopId.toString(),
                  };
                  Get.back();
                  _homeController.setRxRequestStatus(Status.LOADING);
                  await HomeScreenController().stopTrip(data);
                  await _homeController.tripsCircleApi();
                  Future.delayed(Duration(seconds: 2));
                  _homeController.setRxRequestStatus(Status.COMPLETED);
                },
              );
            });
          },
              child: KText(text: "Arrived", color: kMainColor, fontSize: 18));
        }
        else if(nextStop!.type == "destination"){
          return OutlinedButton(onPressed: () async {
            showDialog(context: context, builder: (context){
              return KAlertDialog(
                title: "Arrived At Destination",
                content: "Are you sure you reach the destination point?",
                isCancel: true,
                isOk: true,
                cancelOnPressed: (){
                  Get.back();
                },
                okOnPressed: () async {
                  Map<String, dynamic> data = {
                    "trip_id": tripId.toString(),
                    "stop_id": nextStop!.stopId.toString(),
                  };
                  Get.back();
                  _homeController.setRxRequestStatus(Status.LOADING);
                  await HomeScreenController().stopTrip(data);
                  await _homeController.tripsCircleApi();
                  Future.delayed(Duration(seconds: 2));
                  _homeController.setRxRequestStatus(Status.COMPLETED);
                },
              );
            });
          },
              child: KText(text: "Arrived", color: kMainColor, fontSize: 18));
        }
      }
      else if ( status == "destination" && nextStop!.type == "destination"){
        return OutlinedButton(onPressed: () async {
          showDialog(context: context, builder: (context){
            return KAlertDialog(
              title: "End Trip",
              content: "Are you sure you want to end this trip?",
              isCancel: true,
              isOk: true,
              cancelOnPressed: (){
                Get.back();
              },
              okOnPressed: () async {
                Get.back();
                _homeController.setRxRequestStatus(Status.LOADING);
                await HomeScreenController().endTrip(tripId!);
                await _homeController.tripsCircleApi();
                Future.delayed(Duration(seconds: 2));
                _homeController.setRxRequestStatus(Status.COMPLETED);
              },
            );
          });
        },
            child: KText(text: "End Trip", color: kMainColor, fontSize: 18));
      }
      else {
        return Container();
      }
    }
    catch(e){
      print(e);
    }
    return Container();
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

