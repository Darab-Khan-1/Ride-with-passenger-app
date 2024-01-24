
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Widgets/dialog/custom_alert_dialog.dart';
import 'package:ride_with_passenger/Widgets/form_fields/expandable_text.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/constants/enums.dart';
import 'package:ride_with_passenger/controller/all_job_controller/all_job_controller.dart';
import 'package:ride_with_passenger/controller/auth_controller/auth_controller.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';
import 'package:ride_with_passenger/model/on_going_trip_model/ongoing_trip_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../constants/colors.dart';

class CurrentTripCard extends StatelessWidget {
  OnGoingTripData model = OnGoingTripData();

  CurrentTripCard({Key? key, required this.model})
      : super(key: key);
final _homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: const Offset(
                1.0,
                1.0,
              ),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpandableText(text: "${model.uniqueId}",
                        style: TextStyle(color: kBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),),
                      Text(
                        _statusHeading(model.status!, model.nextStop!.type!),
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          color: kBlackColor,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'Ride with Passenger',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          color: kBlackColor,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  tripButton(context)
                ],
              ),
              const Divider(
                color: kGreyColor,
                thickness: 2,
              ),
              // model.status == 'in-transit'?
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'DropOff Location',
              //       style: TextStyle(
              //         fontStyle: FontStyle.normal,
              //         fontWeight: FontWeight.w400,
              //         color: kGreyColor,
              //         fontSize: 16,
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //         launchUrlString(
              //             'https://www.google.com/maps/search/?api=1&query=${model.dropLat},${model.dropLong}');
              //       },
              //       child: const Column(
              //         children: [
              //           Icon(
              //             Icons.directions,
              //           ),
              //           Text("Directions")
              //         ],
              //       ),
              //     )
              //   ],
              // ):
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //      Text(
              //       'PickUp Location',
              //       style: TextStyle(
              //         fontStyle: FontStyle.normal,
              //         fontWeight: FontWeight.w400,
              //         color: kGreyColor,
              //         fontSize: 16,
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {
              //           launchUrlString(
              //               'https://www.google.com/maps/search/?api=1&query=${model.lat},${model.long}');
              //       },
              //       child: const Column(
              //         children: [
              //           Icon(
              //             Icons.directions,
              //           ),
              //           Text("Directions")
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              // model.status == 'in-transit'?
              Text(
                model.pickupLocation!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: kBlackColor,
                  fontSize: 15,
                ),
                overflow: TextOverflow.visible,
              ),
              Text(
                model.deliveryLocation!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: kBlackColor,
                  fontSize: 15,
                ),
                overflow: TextOverflow.visible,
              ),
              const SizedBox(
                height: 10,
              ),
              ExpandableText(text: descText(), style: const TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w800,
                color: kBlackColor,
                fontSize: 15,
              ),),
            ],
          ),
        ),
      ),
    );
  }

  _statusHeading(String loadstatus, String type) {
    try{
      if (loadstatus == 'started') {
        return 'Way to Pick-Up';
      }
      else if (loadstatus == 'pickup') {
        return 'Arrived at Pick-Up';
      }
      else if (loadstatus == 'in-transit') {
        if(type == "stop"){
          return "Way to Next Stop";}
        else if(type == "destination"){
          return "Way to Destination";
        }
      }else if (loadstatus == 'stopped') {
        return 'Arrived at Stop';
      }
      else if (loadstatus == 'destination'){
        return 'Arrived at Delivery';
      }
      else {
        return 'Way to Pick-Up';
      }
    }catch (e) {
      print(e);
    }
  }

  Widget tripButton(BuildContext context) {
    try {
      if (model.status == 'started') {
        return OutlinedButton(onPressed: () async {
          showDialog(context: context, builder: (context){
            return KAlertDialog(
              title: "Arrived At PickUp",
              content: "Are you sure you reach the pickup point?",
              isCancel: true,
              isOk: true,
              cancelOnPressed: (){
                Get.back();
              },
              okOnPressed: () async {
                Get.back();
                _homeController.setRxRequestStatus(Status.LOADING);
                await HomeScreenController().pickupTrip(model.id!);
                await _homeController.tripsCircleApi();
                Future.delayed(Duration(seconds: 2));
                _homeController.setRxRequestStatus(Status.COMPLETED);
              },
            );
          });
        },
            child: KText(text: "Arrived", color: kMainColor, fontSize: 18));
      }
      else if (model.status == 'pickup') {
        return OutlinedButton(onPressed: () {

        },
            child: KText(text: "Start", color: kMainColor, fontSize: 18));
      }
      else if (model.status == 'stopped') {
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
                await HomeScreenController().exitStop(model.id!, model.currentStop);
                await _homeController.tripsCircleApi();
                Future.delayed(Duration(seconds: 2));
                _homeController.setRxRequestStatus(Status.COMPLETED);
              },
            );
          });
        },
            child: KText(text: "Exit", color: kMainColor, fontSize: 18));
      }
      else if (model.status == 'in-transit') {
        if(model.nextStop!.type == "stop"){
          return OutlinedButton(onPressed: () async {
            showDialog(context: context, builder: (context){
              return KAlertDialog(
                title: "Arrived At Stop",
                content: "Are you sure you reach at the stop?",
                isCancel: true,
                isOk: true,
                cancelOnPressed: (){
                  Get.back();
                },
                okOnPressed: () async {
                  Get.back();
                  _homeController.setRxRequestStatus(Status.LOADING);
                  await HomeScreenController().stopTrip(model.id!, model.nextStop!.stopId!);
                  await _homeController.tripsCircleApi();
                  Future.delayed(Duration(seconds: 2));
                  _homeController.setRxRequestStatus(Status.COMPLETED);
                },
              );
            });
          },
              child: KText(text: "Arrived", color: kMainColor, fontSize: 18));
        }
        else if(model.nextStop!.type == "destination"){
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
                  Get.back();
                  _homeController.setRxRequestStatus(Status.LOADING);
                  await HomeScreenController().stopTrip(model.id!, model.nextStop!.stopId!);
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
      else if ( model.status == "destination" && model.nextStop!.type == "destination"){
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
                await HomeScreenController().endTrip(model.id!);
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

  descText(){
    if(model.status == "started"){
      return model.nextStop!.description;
    }
    else if(model.status == "pickup"){
      return "Arrived at Pick-Up";
    }
    else if(model.status == "in-transit"){
      if(model.nextStop!.type == "stop"){
        var desc = model.stops!.where((element) => element.id == model.nextStop!.stopId).first.description;
        return desc;
      }
      else if(model.nextStop!.type == "destination"){
        return model.nextStop!.description;
      }
    }
    else if(model.status == "stopped"){
      var desc = model.stops!.where((element) => element.id == model.nextStop!.stopId).first.description;
      return desc;
    }
    else if(model.status == "destination" && model.nextStop!.type == "destination"){
      return model.nextStop!.description;
    }
    else{
      return "Way to Pick-Up";
    }
  }
}
