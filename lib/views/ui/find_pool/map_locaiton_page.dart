import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/reuseable_text_widget.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key, required this.places}) : super(key: key);
  final List<LatLng> places;

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  late CameraPosition cameraPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  LocationPermission? _locationPermission;

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfLocationPermissionAllowed();
    cameraPosition = CameraPosition(
        target: LatLng(widget.places[0].latitude, widget.places[0].longitude),
        zoom: 14.4746);
    setState(() {
      for (int i = 0; i < widget.places.length; i++) {
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              position: widget.places[i],
              infoWindow: InfoWindow(title: "fjasfa"),
              icon: BitmapDescriptor.defaultMarker),
        );
      }

      _polyline.add(Polyline(
          polylineId: PolylineId('1'),
          color: loginPageColor,
          points: widget.places));
    });
  }

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
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        polylines: _polyline,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          print("Google map created");
          _googleMapController.complete(controller);
          newGoogleMapController = controller;
        },
      ),
    );
  }
}
