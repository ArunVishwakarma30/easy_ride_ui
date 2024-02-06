import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/services/helper/create_ride_helper.dart';
import 'package:easy_ride/views/common/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/map/direction_model.dart';
import 'map_provider.dart';

class FindPoolProvider extends ChangeNotifier {
  DateTime? _travelDateTime = DateTime.now();
  late Future<List<SearchRidesResModel>> searchResult;

  get travelDateTime => _travelDateTime;

  void setTravelDateTime(BuildContext context) async {
    DateTime? tempDate = await pickDate(context);
    if (tempDate == null) {
      return;
    } else {
      TimeOfDay? tempTime = await pickTime(context);
      if (tempTime == null) {
        return;
      } else {
        final dateTime = DateTime(tempDate.year, tempDate.month, tempDate.day,
            tempTime.hour, tempTime.minute);
        _travelDateTime = dateTime;
      }
    }
    notifyListeners();
  }

  getSearchResult(SearchRidesReqModel model) {
    searchResult = CreateRideHelper.searchRides(model);
  }

  String getStateFromAddress(String address) {
    // Split the address by commas
    final addressComponents = address.split(',');

    // Check if there are enough components
    if (addressComponents.length >= 3) {
      // The state name is the last but one component after trimming any leading or trailing whitespace
      final state = addressComponents[addressComponents.length - 3].trim();
      return state;
    } else {
      // Return an empty string or throw an exception based on your use case
      return '';
    }
  }

  String extractAddressPart(String address) {
    // Split the address into a list using commas as delimiters
    List<String> addressParts = address.split(',');

    // Find the indices of the second last comma and 4th last comma
    int secondLastCommaIndex = addressParts.length - 2;
    int fourthLastCommaIndex = addressParts.length - 4;

    // Extract the values from 4th last comma to 2nd last comma
    List<String> desiredValues =
        addressParts.sublist(fourthLastCommaIndex, secondLastCommaIndex);

    // Join the extracted values into a single string
    String result = desiredValues.join(',');

    return result.trim(); // Trim to remove leading and trailing whitespaces
  }

  Future<List<dynamic>> getRouteDetails(
      SearchRidesResModel searchResult, BuildContext context) async {
    // at index [0] it will contain the List<LatLng> coordinates
    // at index [1] there is a String which is for polyLine
    // at index [2] there is a List<int> hrs
    // at index [3] there is a List<int> mins
    List<dynamic> routeRes = [];
    var mapProvider = Provider.of<MapProvider>(context, listen: false);
    List<LatLng> coordinates = [];

    for (StopBy stop in searchResult.stopBy) {
      String? placeId = stop.gMapAddressId;

      Directions? coordinatesDetails =
          await MapProvider().getPlaceDirectionDetails(placeId);

      if (coordinatesDetails != null &&
          coordinatesDetails.locationLatitude != null &&
          coordinatesDetails.locationLongitude != null) {
        coordinates.add(
          LatLng(
            coordinatesDetails.locationLatitude!,
            coordinatesDetails.locationLongitude!,
          ),
        );
      }
    }
    routeRes.add(coordinates);
    var directionDetailInfo =
        await mapProvider.getOriginToDestinationDirectionDetails(coordinates);
    routeRes.add(directionDetailInfo![0]!.ePoints!);

    // Extracting hours and minutes from each DirectionDetailsInfo
    List<int> hrs = [];
    List<int> mins = [];

    for (int i = 0; i < directionDetailInfo.length; i++) {
      int durationInSeconds = directionDetailInfo[i]!.durationValue!;
      int hour = durationInSeconds ~/ 3600; // 1 hour = 3600 seconds
      int minute = (durationInSeconds % 3600) ~/ 60;

      // Adding hours and minutes to the respective lists
      hrs.add(hour);
      mins.add(minute);
    }

    // Adding hours and minutes lists to the result
    routeRes.add(hrs);
    routeRes.add(mins);

    return routeRes;
  }
}
