import 'dart:convert';

import 'package:easy_ride/models/request/add_vehicle_req_model.dart';
import 'package:easy_ride/models/request/update_is_default_req_model.dart';
import 'package:easy_ride/models/response/get_vehicle_res_model.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class VehicleHelper {
  static var client =
      https.Client(); //This client is used to send HTTP requests

  // Add Vehicle to database
  static Future<bool> addVehicle(AddVehicleReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.vehicleUrl}");
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // get an users all vehicle response
  static Future<List<GetVehicleResModel>> getAllVehicles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.getVehicleUrl}/$userId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var vehicleRes = getVehicleResModelFromJson(response.body);
      return vehicleRes;
    } else {
      throw Exception("Failed to get the vehicle data");
    }
  }

  // Delete vehicle
  static Future<bool> deleteVehicle(String vehicleId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.vehicleUrl}/$vehicleId");
    var response = await client.delete(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Update Vehicle
  static Future<bool> updateVehicle(
      AddVehicleReqModel model, String vehicleId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.vehicleUrl}/$vehicleId");
    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Update Vehicle
  static Future<bool> updateIsDefault(
      UpdateIsDefaultReq model, String vehicleId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.vehicleUrl}/$vehicleId");
    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
