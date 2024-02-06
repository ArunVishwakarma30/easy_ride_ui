import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:easy_ride/services/helper/your_rides_helper.dart';
import 'package:flutter/cupertino.dart';

class YourRidesProvider extends ChangeNotifier {
  late Future<List<YourCreatedRidesResModel>>? allCreatedRides;

  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  getAllCreatedRides() {
    allCreatedRides = YourRidesHelper.getAllCreatedRides();
  }
}
