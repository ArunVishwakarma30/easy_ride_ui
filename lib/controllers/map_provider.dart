import 'package:easy_ride/models/map/DirectionDetailsInfo.dart';
import 'package:easy_ride/models/request/create_ride_req_model.dart';
import 'package:easy_ride/services/helper/create_ride_helper.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:easy_ride/views/ui/offer_pool/successfully_ride_created_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/map/direction_model.dart';
import '../models/map/predict_place_model.dart';
import '../services/helper/map_helper.dart';

class MapProvider extends ChangeNotifier {
  List<PredictPlaces> predictPlacesList = [];
  Directions? myLocationDirection;
  Directions? destinationDirection;
  List<Directions> stopOver = [];
  String? vehicleId;
  String? driverId;
  bool instantBooking = false;
  int _pricePerSeat = 20;
  String aboutRide = "null";

  bool _waiting = false;

  int get pricePerSeat => _pricePerSeat;

  void increment(int value) {
    _pricePerSeat += value;
    notifyListeners();
  }

  void setPriceOnChange(int value) {
    _pricePerSeat = value;
  }

  void decrement(int value) {
    _pricePerSeat -= value;
    notifyListeners();
  }

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    driverId = prefs.getString("userId");
    print("fjisfa : $driverId");
  }

  insertLocationAndDestinationToStopOver() {
    stopOver.insert(0, myLocationDirection!);
    stopOver.add(destinationDirection!);
  }

  removeStopOver(int index) {
    stopOver.removeAt(index);
    notifyListeners();
  }

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  void setDirectionsNull() {
    myLocationDirection = null;
    destinationDirection = null;
  }

  void setPredictListToEmpty() {
    predictPlacesList = [];
    notifyListeners();
  }

  // publish ride
  publishRide(CreateRideReqModel model) {
    CreateRideHelper.publishRide(model).then((isRideCreated) {
      if (isRideCreated) {
        // Get.to(()=>const RidePublishedPage(), transition: Transition.fade);

        Get.to(() => const RideCreated(), transition: Transition.fadeIn);
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong",
            icon: Icons.error,
            bgColor: Colors.red,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(), transition: Transition.fade);
      }
      setWaiting(false);
    });
  }

  findPlaceAutoCompleteSearch(String inputText) async {
    if (inputText.length > 1) {
      // String urlAutoCompleteSearch =
      //     'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$map_key';
      String urlAutoCompleteSearch =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$map_key&components=country:IN';

      var res = await MapHelper.getUserAddress(urlAutoCompleteSearch);

      if (res == "Error occurred , Failed to get response") {
        return;
      }
      if (res['status'] == 'OK') {
        var predicted = res['predictions'];

        var predictedList = (predicted as List)
            .map((jsonData) => PredictPlaces.fromJson(jsonData))
            .toList();

        predictPlacesList = predictedList;
        notifyListeners();
      }
    }
  }

  Future<Directions?> getPlaceDirectionDetails(String? placeId) async {
    String placeDirectionDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$map_key';

    var res = await MapHelper.getUserAddress(placeDirectionDetailsUrl);

    if (res == "Error occurred , Failed to get response") {
      return null;
    }

    if (res['status'] == 'OK') {
      Directions directions = Directions();
      directions.locationDescription = res['result']['formatted_address'];
      directions.locationId = placeId;
      directions.locationLatitude =
      res['result']['geometry']['location']['lat'];
      directions.locationLongitude =
      res['result']['geometry']['location']['lng'];
      return directions;
    }
    return null;
  }

  // get user current location
  Future<String?> searchAddressForGeoGraphicCoOrdination() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String apiKey =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position
        .latitude}, ${position.longitude}&key=$map_key";
    var apiRes = await MapHelper.getUserAddress(apiKey);
    if (apiRes != "Error occurred , Failed to get response") {
      String? placeId = apiRes['results'][0]['place_id'];
      return placeId;
    }
    return null;
  }

  // here find the route for the travelling
  Future<DirectionDetailsInfo?> getOriginToDetinationDirectionDetails(
      LatLng originPosition, LatLng destinationPosition) async {
    String routeApiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition
        .latitude},${originPosition.longitude}&destination=${destinationPosition
        .latitude},${destinationPosition.longitude}&key=$map_key";

    var response = await MapHelper.getUserAddress(routeApiUrl);
    if (response == "Error occurred , Failed to get response") {
      return null;
    }

    DirectionDetailsInfo routeInfo = DirectionDetailsInfo();
    // routeInfo.ePoints = response['']
  }
}
