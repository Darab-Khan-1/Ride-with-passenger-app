
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_with_passenger/Widgets/dialog/custom_alert_dialog.dart';
import 'package:ride_with_passenger/constants/colors.dart';
import 'package:ride_with_passenger/controller/all_job_controller/all_job_controller.dart';
import 'package:ride_with_passenger/controller/auth_controller/auth_controller.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';
import 'package:ride_with_passenger/view/notification_screen/notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/cards/current_trip_card/current_trip_card.dart';
import '../../Widgets/form_fields/k_text.dart';
import '../../constants/enums.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final _tripController = Get.put(TripController());
  final _homeController = Get.put(HomeScreenController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences.getInstance().then((value) async {
        if(!(value.containsKey("isLocation")) && !(value.containsKey("isLocation"))){
          if(_homeController.isalert.value == false) {
            await _homeController.alertbox();
          }
        }else{
          _homeController.getCurrentLocation();
        }

      } );
    await _homeController.countNotification();
    await _homeController.tripsCircleApi();
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) {
          return  Scaffold(
              appBar: AppBar(
                title: Text("Map View"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return KAlertDialog(
                          title: "Logout",
                          content: "Are you sure you want to logout?",
                          isOk: true,
                          isCancel: true,
                          okOnPressed: () {
                            AuthController().logoutApi(context);
                          },
                          cancelOnPressed: () {
                            Get.back();
                          },
                        );
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => NotificationScreen())!.then((value) async => await controller.countNotification());
                      },
                      child: controller.totalNot.value == 0 ? Icon(Icons.notifications) :
                      Badge(
                        label: KText(text: controller.totalNot.value.toString(), color: Colors.white, fontSize: 10,),
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                child: Stack(
                  children: [
                    Obx(() => GoogleMap(
                      compassEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      trafficEnabled: true,
                      initialCameraPosition: _homeController.currentPosition.value == null ? CameraPosition(
                        target: LatLng(37.7749, -122.4194),zoom: 14.4746,
                      ):
                      CameraPosition(
                          target:
                          LatLng(_homeController.currentPosition.value!.latitude!, _homeController.currentPosition.value!.longitude! ),zoom: _homeController.zoomValue.value),
                      markers: controller.markers,
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                                () => PanGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer()))
                        ..add(Factory<HorizontalDragGestureRecognizer>(
                                () => HorizontalDragGestureRecognizer()))
                        ..add(Factory<ScaleGestureRecognizer>(
                                () => ScaleGestureRecognizer())),
                      polylines: {
                        Polyline(
                          polylineId: PolylineId('route1'),
                          visible: true,
                          //latlng is List<LatLng>
                          points: controller.routeCoordinates,
                          width: 4,
                          color: kMainColor,
                        ),
                      },
                      // mapToolbarEnabled: true,
                      mapType: MapType.normal,
                      onMapCreated: (GoogleMapController controller) async {
                        _homeController.mapController = controller;
                      },
                      onCameraMove: (CameraPosition position) {
                        // log( "Current position Zoom Value" + position.zoom.toString());
                        _homeController.updateZoomValue(position.zoom);

                      },
                      // minMaxZoomPreference: MinMaxZoomPreference(10, 20),

                    )),
                    Positioned(
                      top: 20,
                      left: 10,
                      right: 10,
                      child: Obx(() {
                        switch (controller.rxRequestStatus.value) {
                          case Status.LOADING:
                            return const Center(child: CircularProgressIndicator());
                          case Status.ERROR:
                            if (controller.error.value == 'No internet') {
                              return Column(children: [
                                KText(text: "No Internet"),
                                ElevatedButton(onPressed: (){
                                  controller.tripsCircleApi();
                                }, child: KText(text: "Retry",))
                              ],);
                            } else {
                              return Center(
                                child: Column(children: [
                                  KText(text: "Something went wrong"),
                                  ElevatedButton(onPressed: (){
                                    controller.tripsCircleApi();
                                  }, child: KText(text: "Retry",))
                                ],),
                              );
                            }
                          case Status.COMPLETED:
                            if(controller.ongoingTrip.value.data != null ) {
                              return Container(
                                height: Get.height * 0.3,
                                width: Get.width * 0.9,
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    var data = controller.ongoingTrip.value.data!;
                                    return CurrentTripCard(
                                      model: data,
                                    );
                                  },
                                ),
                                //   ),
                              );
                            }
                            return Container();
                        }

                      }),
                    ),
                    Positioned(
                      bottom: 40.0,
                      left: 16.0,
                      child: Container(
                          width: 65,
                          height: 65,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text( "${controller.speed.value.toStringAsFixed(2)}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                              Text("Km/hr", style: TextStyle(color: Colors.black, fontSize: 11),)
                            ],
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: kPrimaryColor,
                                width: 5,
                              )
                          )),
                    ),
                  ],
                ),
              )
          );
        });
  }
}
