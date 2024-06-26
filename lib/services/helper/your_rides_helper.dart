import 'dart:convert';

import 'package:easy_ride/models/request/accept_or_deny_req.dart';
import 'package:easy_ride/models/request/cancel_ride_req_model.dart';
import 'package:easy_ride/models/request/finish_ride_req_model.dart';
import 'package:easy_ride/models/request/req_ride_model.dart';
import 'package:easy_ride/models/request/send_otp_req_model.dart';
import 'package:easy_ride/models/request/start_ride_req.dart';
import 'package:easy_ride/models/request/verify_otp_req_model.dart';
import 'package:easy_ride/models/response/requested_ride_res_model.dart';
import 'package:easy_ride/models/response/send_otp_res_model.dart';
import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class YourRidesHelper {
  static var client = https.Client();

  // get an users all created rides response
  static Future<List<YourCreatedRidesResModel>> getAllCreatedRides() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.getAllCreatedRides}/$userId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var ridesRes = yourCreatedRidesResModelFromJson(response.body);
      return ridesRes;
    } else {
      throw Exception("Failed to get the rides data");
    }
  }

  // cancel Ride
  static Future<bool> cancelRide(
      CancelRideReqModel model, String rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.createRideUrl}/$rideId");
    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // get an users all requested rides response
  static Future<List<RequestedRidesResModel>> getAllRequestedRides() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url =
        Uri.parse("${Config.apiUrl}${Config.getAllRequestedRides}/$userId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var ridesRes = requestedRidesResModelFromJson(response.body);
      return ridesRes;
    } else {
      throw Exception("Failed to get the rides data");
    }
  }

  // update or decline user ride request
  // update user profile
  static Future<bool> acceptOrDeclineUserRideRequest(AcceptOrDenyReq model, String rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.requestRide}/$rideId");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // start ride
  static Future<bool> startRide(StartRideReq model, String rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.createRideUrl}/$rideId");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // start ride
  static Future<bool> finishRide(FinishRideReq model, String rideId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.createRideUrl}/$rideId");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // send OPT
  static Future<List<dynamic>> sendOTP(SendOtpReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiUrl}${Config.sendOTPUrl}");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      var sendOtpRes = sendOtpResModelFromJson(response.body);
      return [true, sendOtpRes];
    } else {
      throw Exception("Failed to Send OTP");
    }
  }

  // verify OTP
  static Future<bool> verifyOTP(VerifyOtpReqModel model) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse("${Config.apiUrl}${Config.verifyOTPURL}");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    print(response.statusCode);
    print(response.body.toString());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


}
