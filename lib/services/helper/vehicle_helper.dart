import 'package:easy_ride/models/response/get_vehicle_res_model.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class VehicleHelper {
  static var client =
      https.Client(); //This client is used to send HTTP requests

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
}
