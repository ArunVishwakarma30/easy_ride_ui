import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_ride/controllers/map_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/reuseable_text_widget.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen(
      {Key? key, required this.places, required this.polyLinePoints})
      : super(key: key);
  final List<LatLng> places;
  final String polyLinePoints;

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
  final List<LatLng> pLineCoordinatedList = [];

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
        zoom: 12.4746);
    setState(() {
      _generateMarkers();
      drawPolyLines();
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _generateMarkers() async {
    for (int i = 0; i < widget.places.length; i++) {
      late final Uint8List markerIcon;
      if (i == 0) {
        markerIcon =
            await getBytesFromAsset('assets/icons/my_location.png', 100);
      } else if (i == widget.places.length - 1) {
        markerIcon = await getBytesFromAsset(
            'assets/icons/destination_location.png', 100);
      } else {
        markerIcon =
            await getBytesFromAsset('assets/icons/pick_location.png', 200);
      }
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: widget.places[i],
          consumeTapEvents: false,
          infoWindow: InfoWindow(
            title: "fjasfa",
            snippet: "fjiasoflasf",
          ),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        ),
      );
    }
    setState(() {});
  }

  drawPolyLines() {
    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyPointResult =
        pPoints.decodePolyline(widget.polyLinePoints);

    if (decodedPolyPointResult.isNotEmpty) {
      decodedPolyPointResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinatedList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    setState(() {
      _polyline.add(Polyline(
          polylineId: const PolylineId('2'),
          jointType: JointType.round,
          color: loginPageColor,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true,
          width: 5,
          points: pLineCoordinatedList));
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
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
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
