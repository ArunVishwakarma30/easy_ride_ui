import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/chats/get_chat_res_model.dart';
import '../config.dart';

class ChatHelper {
  static var client = https.Client();
//
// // apply for jobs
// // we will be sending first message from system to initialise the chat
//   static Future<List<dynamic>> applyJob(CreateChat model) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//       'token': "Bearer $token"
//     };
//     var url = Uri.parse("${Config.apiUrl}${Config.chatUrl}");
//     var response = await client.post(url,
//         headers: requestHeaders, body: jsonEncode(model.toJson()));
//
//     if (response.statusCode == 200) {
//       var first = initialChatFromJson(response.body).id;
//       return [true, first];
//     } else {
//       return [false];
//     }
//   }

  static Future<List<GetChats>> getConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': "Bearer $token"
    };
    var url = Uri.parse("${Config.apiUrl}${Config.chatUrl}");
    var response = await client.get(url,
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var chats = getChatsFromJson(response.body);
      print(response.body.toString());
      return chats;
    } else {
      throw Exception("Couldn't load chats");
    }
  }


}
