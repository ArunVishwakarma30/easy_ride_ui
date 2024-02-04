import 'dart:convert';

import 'package:http/http.dart' as https;

class MapHelper {
  static Future<dynamic> getUserAddress(String url) async {
    https.Response res = await https.get(Uri.parse(url));

    try {
      if (res.statusCode == 200) {
        String responseData = res.body; // json
        var decodedResponseData = jsonDecode(responseData);

        return decodedResponseData;
      } else {
        return "Error occurred , Failed to get response";
      }
    } catch (exp) {
      return "Error occurred , Failed to get response";
    }
  }

}
