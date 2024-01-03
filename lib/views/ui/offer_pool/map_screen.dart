import 'dart:async';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickLocation;

  // loc.Location location = loc.Location();
  String? _address;

  final Completer<GoogleMapController> _googleMapController = Completer();
  static const CameraPosition cameraPosition =
      CameraPosition(target: LatLng(19.0968823, 72.882016), zoom: 15.4746);

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 220;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReuseableText(
            text: "Carpool",
            style: roundFont(22, Color(darkHeading.value), FontWeight.bold)),
        leading: Container(
          margin: const EdgeInsets.only(left: 15),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);
        },
        initialCameraPosition: cameraPosition,
      ),
    );
  }
}
