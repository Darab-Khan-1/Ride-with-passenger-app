
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';
import 'package:ride_with_passenger/view/trips_screen/my_trips_screen.dart';
import 'package:ride_with_passenger/view/trips_screen/trips_screen.dart';

class TripTabScreen extends StatelessWidget {
  const TripTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripController>(
        init: TripController(),
        builder:(controller){
          return Scaffold(
            appBar: AppBar(
              title: Text("Trips"),
              leading: SizedBox(),
            ),
            body: Container(
              width: Get.width,
              height: Get.height,
              child: Stack(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 70),
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        TripsScreen(),
                        MyTripsScreen()

                      ],
                    ),
                  ),
                  Positioned(
                    child: TabBar(
                      isScrollable: false,
                      onTap: (index) {
                        print("tapped $index");
                        controller.tabController!.index = index;
                        controller.update();
                      },
                      controller: controller.tabController,
                      tabs: [
                        Container(
                            width: 150,
                            height: 60,
                            child: Center(child: Text("All Trips",))),
                        Container(
                            width: 150,
                            height: 50,
                            child: Center(child: Text("My Trips",))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
