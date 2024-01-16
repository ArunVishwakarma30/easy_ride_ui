import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/services/helper/create_ride_helper.dart';
import 'package:easy_ride/views/common/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


}
