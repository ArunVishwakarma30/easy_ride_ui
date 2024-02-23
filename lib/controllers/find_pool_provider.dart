import 'package:easy_ride/models/request/req_ride_model.dart';
import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:easy_ride/models/request/send_notification_req_model.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/services/helper/create_ride_helper.dart';
import 'package:easy_ride/services/helper/notification_helper.dart';
import 'package:easy_ride/services/helper/request_ride_helper.dart';
import 'package:easy_ride/views/common/service.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/common/toast_msg.dart';

class FindPoolProvider extends ChangeNotifier {
  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  DateTime? _travelDateTime = DateTime.now();
  late Future<List<SearchRidesResModel>> searchResult;

  get travelDateTime => _travelDateTime;

  void setTravelDateTime(BuildContext context) async {
    DateTime? tempDate = await pickDate(context);
    if (tempDate == null) {
      return;
    } else {
      TimeOfDay? tempTime = await pickTime(context, tempDate);
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

  // request ride
  requestRide(
      RequestRideReqModel model, SendNotificationReqModel notificationModel) {
    RequestRideHelper.requestRide(model).then((value) {
      if (value) {
        ShowSnackbar(
            title: "Success",
            message: "Ride Successfully Booked!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
        // write a code to send notification to driver
        NotificationHelper.sendNotification(notificationModel);
      } else {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }
}
