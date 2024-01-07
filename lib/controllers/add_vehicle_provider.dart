import 'package:easy_ride/models/response/get_vehicle_res_model.dart';
import 'package:easy_ride/services/helper/vehicle_helper.dart';
import 'package:flutter/widgets.dart';

class AddVehicle extends ChangeNotifier {
  // for seats
  int _numOfSeatSelected = 1;
  late Future<List<GetVehicleResModel>>? allVehicles;

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

  getAllVehicles() {
    allVehicles = VehicleHelper.getAllVehicles();
  }
}
