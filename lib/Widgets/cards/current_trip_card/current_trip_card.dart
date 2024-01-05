
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/Widgets/form_fields/expandable_text.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/model/on_going_trip_model/ongoing_trip_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../constants/colors.dart';

class CurrentTripCard extends StatelessWidget {
OnGoingTripData model = OnGoingTripData();
   CurrentTripCard(
      {Key? key, required this.model})
      : super(key: key);

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
                      ExpandableText(text: "Trip Id: ${model.id}", style: TextStyle(color: kBlackColor, fontSize: 18, fontWeight: FontWeight.bold),),
                      //  Text(
                      //   _statusHeading(model.status!),
                      //   style: TextStyle(
                      //     fontStyle: FontStyle.normal,
                      //     fontWeight: FontWeight.w700,
                      //     color: kBlackColor,
                      //     fontSize: 20,
                      //   ),
                      // ),
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
                  OutlinedButton(onPressed: (){}, child: KText(text: "Stop", color: kMainColor, fontSize: 18)),
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
              // Text(
              //   model.status == 'in-transit'? model.deliveryDate!: model.pickupDate!,
              //   textAlign: TextAlign.start,
              //   style: const TextStyle(
              //     fontStyle: FontStyle.normal,
              //     fontWeight: FontWeight.w400,
              //     color: kBlackColor,
              //     fontSize: 15,
              //   ),
              //   overflow: TextOverflow.visible,
              // ),
            ],
          ),
        ),
      ),
    );
  }
  String _statusHeading(String status) {
    switch (status) {
      case 'started':
        return 'In Transit to Pick-Up';
      case 'in-transit':
        return 'In Transit to Delivery';
      case 'completed':
        return 'Arrived at Delivery';
      default:
        return 'Unknown';
    }
  }
}
