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
      throw Exception("Failed to get the vehicle data");
    }
  }
}
