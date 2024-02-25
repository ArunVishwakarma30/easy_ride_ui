import 'package:easy_ride/models/request/cancel_ride_req_model.dart';
import 'package:easy_ride/models/response/requested_ride_res_model.dart';
import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:easy_ride/services/helper/your_rides_helper.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourRidesProvider extends ChangeNotifier {
  late Future<List<YourCreatedRidesResModel>>? allCreatedRides;
  late Future<List<RequestedRidesResModel>>? allRequestedRides;
  late YourCreatedRidesResModel createdRide;

  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  getAllCreatedRides() {
    allCreatedRides = YourRidesHelper.getAllCreatedRides();
  }

  getAllRequestedRides() {
    allRequestedRides = YourRidesHelper.getAllRequestedRides();
  }

  cancelRide(CancelRideReqModel model, String rideId) {
    YourRidesHelper.cancelRide(model, rideId).then((value) {
      if (value) {
        ShowSnackbar(
            title: "Successful",
            message: "Your Ride  is Successfully.",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage());
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong! Please try again later.",
            icon: Icons.error,
            bgColor: Colors.red,
            textColor: Colors.white);
      }
    });
  }
}
