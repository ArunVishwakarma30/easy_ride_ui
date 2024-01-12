import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_constants.dart';
import '../models/map/direction_model.dart';
import '../models/map/predict_place_model.dart';
import '../services/helper/map_helper.dart';

class MapProvider extends ChangeNotifier {
  List<PredictPlaces> predictPlacesList = [];
  Directions? myLocationDirection;
  Directions? destinationDirection;

  bool _waiting = false;

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
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude}, ${position.longitude}&key=$map_key";
    var apiRes = await MapHelper.getUserAddress(apiKey);
    if (apiRes != "Error occurred , Failed to get response") {
      String? placeId = apiRes['results'][0]['place_id'];
      return placeId;
    }
    return null;
  }
}
