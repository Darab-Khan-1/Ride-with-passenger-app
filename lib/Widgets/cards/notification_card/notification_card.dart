import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_with_passenger/constants/colors.dart';
import 'package:ride_with_passenger/controller/notification_controller/notification_controller.dart';
import 'package:ride_with_passenger/model/notification_model/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData  notification;

   NotificationCard({super.key, required this.notification});
final controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    IconData iconData = Icons.notification_important; // Default icon

    if (notification.type == "message") {
      iconData = Icons.message;
    } else if (notification.type == "notification") {
      iconData = Icons.notifications;
    }

    return Obx(() => Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(iconData, color: Colors.blue),
        title: Text(
          notification.title!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: controller.seen.value || notification.seen == "1"
            ? Icon(Icons.check_circle, color: kGreenColor)
            : Icon(Icons.check_circle, color: kGreyColor),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.notification!,
              style: TextStyle(fontSize: 14),
            ),
            const Gap(8),
            Text(
              'Created at: ${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(notification.createdAt!))}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        onTap: () {
          // Handle tapping on the notification
          // You can navigate to a detailed view or perform any other action
        },
      ),
    ));
  }
}