import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_with_passenger/controller/auth_controller/auth_controller.dart';
import 'package:ride_with_passenger/controller/trip_controller/trip_controller.dart';

import '../../Widgets/cards/current_trip_card/current_trip_card.dart';
import '../../Widgets/form_fields/k_text.dart';
import '../../constants/enums.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _tripController = Get.put(TripController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Map View"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                AuthController().logoutApi(context);
              },
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: [
            GoogleMap(
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            trafficEnabled: true,
            initialCameraPosition: _tripController.currentPosition.value == null ? CameraPosition(
                target: LatLng(37.7749, -122.4194),zoom: 14.4746,
            ):
            CameraPosition(
                target:
                LatLng(_tripController.currentPosition.value!.latitude!, _tripController.currentPosition.value!.longitude! ),zoom: _tripController.zoomValue.value),
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
                points: _tripController.routeCoordinates,
                width: 4,
                color: Colors.red,
              ),
            },
            // mapToolbarEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) async {
              _tripController.mapController = controller;
            },
            onCameraMove: (CameraPosition position) {
              log( "Current position Zoom Value" + position.zoom.toString());
              _tripController.updateZoomValue(position.zoom);

            },
            minMaxZoomPreference: MinMaxZoomPreference(10, 20),

          ),
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Obx(() {
                  switch (_tripController.rxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator.adaptive());
                    case Status.ERROR:
                      if (_tripController.error.value == 'No internet') {
                        return Column(children: [
                          KText(text: "No Internet"),
                        ],);
                      } else {
                        return Center(
                          child: Column(children: [
                            KText(text: "Something went wrong"),
                            ElevatedButton(onPressed: (){
                              // currentTripVM.onGoingTrip();
                            }, child: KText(text: "Retry",))
                          ],),
                        );
                      }
                    case Status.COMPLETED:
                      if(_tripController.ongoingTrip.value.data != null ) {
                        return Container(
                          height: Get.height * 0.3,
                          width: Get.width * 0.9,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              var data = _tripController.ongoingTrip.value.data!;
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
            ],
          ),
        )
    );
  }
}
