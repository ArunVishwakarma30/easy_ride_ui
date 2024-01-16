import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/find_pool_provider.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/find_pool/get_all_available_rides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/map_provider.dart';
import '../../common/travel_detail_widget.dart';
import 'car_design.dart';

class FindPoolPage extends StatefulWidget {
  const FindPoolPage({super.key});

  @override
  State<FindPoolPage> createState() => _FindPoolPageState();
}

class _FindPoolPageState extends State<FindPoolPage> {
  String? leaveFromLocation;
  String? dropLocation;
  DateTime? dateTime;
  late int numOfSeatsSelected;
  late DateTime? providerDateTime;

  // on Find pool search Button Pressed
  void searchBtnPressed() {
    print("Find Pool Button Pressed");
    if (context.read<MapProvider>().myLocationDirection != null && context.read<MapProvider>().destinationDirection != null) {

      print(leaveFromLocation);
      print(dropLocation);
      print(numOfSeatsSelected);
      print(providerDateTime);
     Get.to(()=>const GetAllAvailableRides(), transition: Transition.rightToLeft);
    }else{
      ShowSnackbar(title: "Failed", message: "Please Enter Both Locations", icon: Icons.error_outline);

    }
  }

  // on Recent Search Item tapped
  void onTapRecentSearchItem(String? value) {
    print(value);
  }

  void selectSeats() {
    showDialog(
      context: context,
      builder: (context) {
        return const CarDesign();
      },
    );
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: TravelDetails(
        searchBtnText: "Find Pool",
        searchBtnPressed: searchBtnPressed,
        onLeaveFromTextChange: onLeaveFromLocationChanged,
        onGoingToTextChange: onDropLocationChanged,
        selectSeats: selectSeats,
        onTapRecentSearchItem: onTapRecentSearchItem,
        heading: "Your pick of rides at low prices",
        isOfferPoolPage: false,
      ),
    );
  }
}
