import 'dart:convert';

import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/search_ride_res_model.dart';
import '../config.dart';

class CreateRideHelper {
  static var client = https.Client();

  // search rides
  static Future<List<SearchRidesResModel>> searchRides(
      SearchRidesReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.searchRideUrl}");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    print("${response.body}");
    if (response.statusCode == 200) {
      var rides = searchRidesResModelFromJson(response.body);
      return rides;
    } else {
      throw Exception("Failed to get the rides data");
    }
  }
}
