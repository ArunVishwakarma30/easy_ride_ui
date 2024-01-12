import 'dart:async';

import 'package:easy_ride/views/ui/driver_verification/driver_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/find_pool_provider.dart';
import '../../common/travel_detail_widget.dart';

class OfferPool extends StatefulWidget {
  const OfferPool({super.key});

  @override
  State<OfferPool> createState() => _OfferPoolState();
}

class _OfferPoolState extends State<OfferPool> {
  void getPrefValue() async {
    var prefs = await SharedPreferences.getInstance();
    bool isTrue = prefs.getBool("isDriverVerified") ?? false;
    if (!isTrue) {
      Get.to(() => const DriverVerification());
    }
  }

  @override
  void initState() {
    super.initState();
    getPrefValue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  String? leaveFromLocation;
  String? dropLocation;
  DateTime? dateTime;
  late int numOfSeatsSelected;
  late DateTime? providerDateTime;

  // on Find pool search Button Pressed
  void searchBtnPressed() async {
    var prefs = await SharedPreferences.getInstance();
    bool isTrue = prefs.getBool("isDriverVerified") ?? false;
    if (!isTrue) {
      Get.to(() => const DriverVerification());
    } else {
      print("offer Pool Button Pressed");
      print(leaveFromLocation);
      print(dropLocation);
      print(numOfSeatsSelected);
      print(providerDateTime);
    }
  }

  // on Recent Search Item tapped
  void onTapRecentSearchItem(String? value) {
    print(value);
    // TODO : write a code for recent searches
  }

  // on Leave From location changed
  void onLeaveFromLocationChanged(String? value) {
    leaveFromLocation = value;
  }

  // on Leave From location changed
  void onDropLocationChanged(String? value) {
    dropLocation = value;
  }

  @override
  Widget build(BuildContext context) {
    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    providerDateTime = findPoolProvider.travelDateTime!;

    final addVehicleProvider = Provider.of<AddVehicle>(context);
    numOfSeatsSelected = addVehicleProvider.numOfSeatSelected;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Background color for the status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for better visibility
    ));
    return GestureDetector(
      onTap: () {
        getPrefValue();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TravelDetails(
          searchBtnText: "Offer Pool",
          searchBtnPressed: searchBtnPressed,
          onLeaveFromTextChange: onLeaveFromLocationChanged,
          onGoingToTextChange: onDropLocationChanged,
          onTapRecentSearchItem: onTapRecentSearchItem,
          heading: "Enjoy a stress-free and \nsocial commute experience",
          isOfferPoolPage: true,
        ),
      ),
    );
  }
}
