import 'package:easy_ride/models/request/add_vehicle_req_model.dart';
import 'package:easy_ride/models/request/update_is_default_req_model.dart';
import 'package:easy_ride/models/response/get_vehicle_res_model.dart';
import 'package:easy_ride/services/helper/vehicle_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/common/toast_msg.dart';
import '../views/ui/bottom_nav_bar/main_page.dart';

class AddVehicle extends ChangeNotifier {
  // for seats
  int _numOfSeatSelected = 1;
  late Future<List<GetVehicleResModel>>? allVehicles;
  String? userId = "";

  bool _waiting = false;

  void getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print("AddVehicleProvider $userId");
  }
  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  get numOfSeatSelected => _numOfSeatSelected;

  void updateSelectedSeats(int value) {
    _numOfSeatSelected = value;
    notifyListeners();
  }

  // for default vehicle
  bool _isDefaultVehicle = false;

  get isDefaultVehicle => _isDefaultVehicle;

  void makeVehicleDefault(bool value) {
    _isDefaultVehicle = value;
    notifyListeners();
  }

  // for carrying helmet
  int _carryHelmet = 0;

  get carryHelmet => _carryHelmet;

  void setCarryHelmet(int value) {
    _carryHelmet = value;
    notifyListeners();
  }

  addVehicle(AddVehicleReqModel model) {
    VehicleHelper.addVehicle(model).then((isAdded) {
      if (isAdded) {
        ShowSnackbar(
            title: "Success",
            message: "Vehicle Successfully Added!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }

  getAllVehicles() {
    allVehicles = VehicleHelper.getAllVehicles();
  }

  deleteVehicle(String vehicleId) {
    VehicleHelper.deleteVehicle(vehicleId).then((isDeleted) {
      if (isDeleted) {
        notifyListeners();
        ShowSnackbar(
            title: "Success",
            message: "Vehicle Successfully Removed!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
      } else {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
    });
  }

  updateIsDefault(UpdateIsDefaultReq model, String vehicleId) {
    VehicleHelper.updateIsDefault(model, vehicleId).then((isUpdated) {
      if (isUpdated) {
        notifyListeners();
        ShowSnackbar(
            title: "Success",
            message: "Vehicle Set as default",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
      } else {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
    });
  }
}
