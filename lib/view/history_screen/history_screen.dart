import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ride_with_passenger/Widgets/form_fields/k_text.dart';
import 'package:ride_with_passenger/constants/colors.dart';

import '../../Widgets/cards/history_job_card/history_job_card.dart';
import '../../constants/enums.dart';
import '../../controller/history_controller/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  DateTime? parsedDeliveryDate;
  DateTime? parsePickUpDate;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("History"),
            ),
            body: Obx(() {
              switch (controller.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (controller.error.value == 'No internet') {
                    return KText(text: 'No Internet', color: Colors.red);
                  } else {
                    return Center(
                      child: Column(children: [
                        KText(text: "Something went wrong"),
                        ElevatedButton(onPressed: (){
                          controller.completedTrips();
                        }, child: KText(text: "Retry",))
                      ],),
                    );;
                  }
                case Status.COMPLETED:
                  if(controller.historyList.value.data!.isEmpty){
                    return Center(child: Text("No History Trips"));
                  }
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.historyList.value.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.historyList.value.data![index];
                        var deliveryDateString = controller.historyList.value.data![index].deliveryDate;
                        var pickupDateString = controller.historyList.value.data![index].pickupDate;
                        try {
                          parsedDeliveryDate = DateFormat("MM-dd-yy HH:mm")
                              .parse(deliveryDateString!);
                        } catch (e) {
                          print('Failed to parse date: $e');
                          // Handle the error in a way that makes sense for your application
                          // provide a default value when parsing fails
                        }

                        if (pickupDateString != null &&
                            pickupDateString != 'ASAP') {
                          try {
                            parsePickUpDate =
                                DateFormat("MM-dd-yy HH:mm")
                                    .parse(pickupDateString!);
                          } catch (e) {
                            print('Failed to parse date: $e');
                             // provide a default value when parsing fails
                          }
                        }
                        return HistoryJobCards(
                          pickUpmonth: DateFormat('MMMM').format(parsePickUpDate!),
                          pickUpdate: DateFormat('d').format(parsePickUpDate!),
                          pickUpday:  DateFormat('EEEE').format(parsePickUpDate!),
                          pickUpTime: DateFormat('hh:mm a').format(parsePickUpDate!),
                          deliverTime: DateFormat('hh:mm a').format(parsedDeliveryDate!),
                          deliveryDate: DateFormat('yyyy-MM-dd').format(parsedDeliveryDate!),
                          deliveryDay: DateFormat('dd').format(parsedDeliveryDate!),
                          deliveryYear: DateFormat('yyyy').format(parsedDeliveryDate!),
                          loadId: data.id.toString(),
                          pickupAddress: data.pickupLocation!,
                          deliverAddress: data.deliveryLocation!,
                          dropLat: double.parse(data.dropLat!),
                          dropLng: double.parse(data.dropLong!),
                          pickLat: double.parse(data.lat!),
                          pickLng: double.parse(data.long!),
                          stops: data.stops!,
                          travelTime: data.estimatedTime!,
                          miles: data.estimatedDistance!,
                          customerName: data.customerName!,
                          customerPhone: data.customerPhone!,
                        );
                      });
              }
            }),
          );
        });
  }
}
