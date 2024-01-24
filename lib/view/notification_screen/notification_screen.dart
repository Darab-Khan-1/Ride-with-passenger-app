import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/constants/enums.dart';

import '../../Widgets/cards/notification_card/notification_card.dart';
import '../../constants/colors.dart';
import '../../controller/notification_controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notification"),
            ),
            body: Container(
              child: controller.rxRequestStatus.value == Status.LOADING
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : controller.rxRequestStatus.value == Status.ERROR
                      ? Center(
                          child: Column(
                            children: [
                              Text(controller.error.value),
                              OutlinedButton(
                                onPressed: () {
                                  controller.getNotification();
                                },
                                child: Text("Retry"),
                              )
                            ],
                          ),
                        )
                      :
              controller.notificationList.value.data!.isEmpty
                      ? Center(
                          child: Text("No Notification"),
                        )
                      : ListView.builder(
                itemCount: controller.notificationList.value.data!.length,
                itemBuilder: (context, index) {
                  var data = controller.notificationList.value.data![index];
                  return NotificationCard(notification: data);
                },
              ),
            ),
          );
        });
  }
}
