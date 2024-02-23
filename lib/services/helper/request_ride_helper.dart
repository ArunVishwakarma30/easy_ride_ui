import 'dart:convert';

import 'package:easy_ride/models/request/create_ride_req_model.dart';
import 'package:easy_ride/models/request/req_ride_model.dart';
import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/search_ride_res_model.dart';
import '../config.dart';
class RequestRideHelper {
  static var client = https.Client();

  // publish ride
  static Future<bool> requestRide(RequestRideReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.requestRide}");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}