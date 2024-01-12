import 'dart:async';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/map/direction_model.dart';
import 'package:easy_ride/services/helper/map_helper.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickLocation;
  String? _address;

  // loc.Location location = loc.Location();

  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(49.0968823, 62.882016), zoom: 15.4746);

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  double searchLocationContainerHeight = 220;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentLocation;
  var geoLocation = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoordinationList = [];
  Set<Polyline> polylineSet = {};

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  String userName = "";
  String userEmail = "";

  bool openNavigationDrawer = true;
  bool activeNearbyDriverKeysLoaded = false;

  BitmapDescriptor? activeNearbyIcon;

  void getAddressFromLatLang() async {}

  // this is also written in map_provider, both functions are sane with some changes to work in the page where google map is not present
  void locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentLocation = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentLocation!.latitude, userCurrentLocation!.longitude);
    cameraPosition = CameraPosition(target: latLngPosition, zoom: 15);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    print(userCurrentLocation);
    // ignore: use_build_context_synchronously
    String humanReadableAddress = await searchAddressForGeoGraphicCoOrdination(
        userCurrentLocation!, context);

    print("User Current Address : $humanReadableAddress ");
  }

  // this is also written in map_provider, both functions are sane with some changes to work in the page where google map is not present
  Future<String> searchAddressForGeoGraphicCoOrdination(
      Position position, context) async {
    String apiKey =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$map_key";
    String humanReadableAddress = "";
    var apiRes = await MapHelper.getUserAddress(apiKey);
    if (apiRes != "Error occurred , Failed to get response") {
      humanReadableAddress = apiRes['results'][0]['formatted_address'];

      Directions userPickUpAddress = Directions(
          humanReadableAddress: humanReadableAddress,
          locationLatitude: position.latitude,
          locationLongitude: position.longitude);
    }
    return humanReadableAddress;
  }

  void getAddressFromLatLag() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: pickLocation!.latitude,
          longitude: pickLocation!.longitude,
          googleMapApiKey: map_key);

      _address = data.address;
      setState(() {});
    } catch (e) {
      print(
          "Error occurred in function getAddressFromLatLag to get address : $e");
    }
  }

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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: cameraPosition,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: polylineSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _googleMapController.complete(controller);
              newGoogleMapController = controller;
              locateUserPosition();
            },
            onCameraMove: (CameraPosition? position) {
              if (pickLocation != position!.target) {
                setState(() {
                  pickLocation = position.target;
                });
              }
            },
            onCameraIdle: () {
              getAddressFromLatLag();
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: Image.asset(
                "assets/icons/location.png",
                height: 50,
                width: 50,
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    color: Colors.white),
                child: Text(
                  _address ?? "Set your pickup location",
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ))
        ],
      ),
    );
  }
}
