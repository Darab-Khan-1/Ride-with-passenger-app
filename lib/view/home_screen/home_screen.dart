import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Map View"),
        ),
        body: Container(
          child: GoogleMap(
            compassEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            zoomControlsEnabled: true,
            // markers: gmServices.markers,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
            },
          ),
        )
    );
  }
}
