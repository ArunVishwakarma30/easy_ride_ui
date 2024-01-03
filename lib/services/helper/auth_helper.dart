import 'dart:convert';

import 'package:easy_ride/models/request/login_req_model.dart';
import 'package:easy_ride/models/request/sign_up_req_model.dart';
import 'package:easy_ride/models/response/sign_up_res_model.dart';
import 'package:easy_ride/services/config.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client =
      https.Client(); //This client is used to send HTTP requests

  static Future<int> signUp(SignUpReqModel model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.signupUrl}");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 201) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = signUpResModelFromJson(response.body).userToken;
      String userId = signUpResModelFromJson(response.body).id;

      prefs.setString('token', token);
      prefs.setString('userId', userId);
      prefs.setBool('loggedIn', true);
    }
    return response.statusCode;
  }

  static Future<bool> login(LoginReqModel model) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiUrl}${Config.loginUrl}");

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = signUpResModelFromJson(response.body).userToken;
      String userId = signUpResModelFromJson(response.body).id;

      prefs.setString('token', token);
      prefs.setString('userId', userId);
      prefs.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }
}
