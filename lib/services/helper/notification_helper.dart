import 'dart:convert';

import 'package:easy_ride/models/request/send_notification_req_model.dart';
import 'package:easy_ride/services/config.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHelper {
  static var client =
      https.Client(); //This client is used to send HTTP requests

  static Future<bool> sendNotification(SendNotificationReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiUrl}${Config.sendNotification}");
    var response = await client.post(
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
}
