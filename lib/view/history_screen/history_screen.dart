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
  DateTime? parsedDate;
  DateTime? parsePickUpDate;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (historyVM) {
          return Scaffold(
            appBar: AppBar(
              title: Text("History"),
            ),
            body: Obx(() {
              switch (historyVM.rxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (historyVM.error.value == 'No internet') {
                    return KText(text: 'No Internet', color: Colors.red);
                  } else {
                    return KText(text: 'Something went wrong', color: Colors.red);
                  }
                case Status.COMPLETED:
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        // var deliveryDateString = historyVM
                        //     .tripsList.value.data![index].deliveryDate;
                        // var pickupDateString = historyVM
                        //     .tripsList.value.data![index].pickupDate;
                        // try {
                        //   parsedDate = DateFormat("MM-dd-yy HH:mm")
                        //       .parse(deliveryDateString!);
                        // } catch (e) {
                        //   print('Failed to parse date: $e');
                        //   // Handle the error in a way that makes sense for your application
                        //   parsedDate = DateTime
                        //       .now(); // provide a default value when parsing fails
                        // }
                        //
                        // if (pickupDateString != null &&
                        //     pickupDateString != 'ASAP') {
                        //   try {
                        //     parsePickUpDate =
                        //         DateFormat("MM-dd-yy HH:mm")
                        //             .parse(pickupDateString!);
                        //   } catch (e) {
                        //     print('Failed to parse date: $e');
                        //     parsePickUpDate = DateTime
                        //         .now(); // provide a default value when parsing fails
                        //   }
                        // }
                        return HistoryJobCards(
                          dimension: "23",
                          amount: "2343",
                          dockLevel: "Yes",
                          hazardous: "Yes",
                          note: "hlkjahdslkjfhal",
                          pickUpmonth: DateFormat('MMMM').format(DateTime.now()),
                          pickUpdate: DateFormat('d').format(DateTime.now()),
                          pickUpday:  DateFormat('EEEE').format(DateTime.now()),
                          pickUpTime: DateFormat('hh:mm a').format(DateTime.now()),
                          deliverTime: DateFormat('hh:mm a').format(DateTime.now()),
                          deliveryDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          deliveryDay: DateFormat('dd').format(DateTime.now()),
                          deliveryYear: DateFormat('yyyy').format(DateTime.now()),
                          loadId: "1",
                          price: "100",
                          pickupAddress: "Srinagar",
                          deliverAddress: "Jammu",
                          // time: DateFormat("HH:mm").format( DateFormat('MM-dd-yy HH:mm').parse(
                          //     historyVM.tripsList.value.data![index]
                          //         .deliveryDate!)),
                          weight: "100",
                          distance: "100",
                          type: "Truck",
                          piece: "98789",
                          stackable: 'Yes',

                          // deliverDate: '16',
                          // deliverDay: 'Friday',
                          // deliverMonth: 'June',
                          // deliverTime: '10:51',
                          // pickupName: historyVM
                          //     .tripsList.value.data![index].weight
                          //     ?.toString() ??
                          //     "",
                          // deliverName: 'Dashiell',
                          // podImage: ImageAssets.lady,
                          // unloadingImage: ImageAssets.companyLogo,
                        );
                      });
              }
            }),
          );
        });
  }
}
