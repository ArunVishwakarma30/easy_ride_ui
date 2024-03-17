import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/chat/send_msgs_req.dart';
import '../../models/response/chats/received_msgs_res.dart';
import '../config.dart';

class MessagingHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': "Bearer $token"
    };
    var url = Uri.parse("${Config.apiUrl}${Config.messagingUrl}");
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      ReceivedMessage message =
          ReceivedMessage.fromJson(jsonDecode(response.body));
      print("\n\nMessagingHelper SendMessage return[1] (message) value :\n $message  \n\n");
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      print("MessagingHelper SendMessage return[2] (responseMap) value :\n $responseMap  \n\n");

      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessage>> getMessages(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': "Bearer $token"
    };
    var url = Uri.parse("${Config.apiUrl}${Config.messagingUrl}/$chatId?page=${offset.toString()}");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var messages = receivedMessageFromJson(response.body);
      return messages;
    } else {
      throw Exception("Failed to load messages");
    }
  }
}
