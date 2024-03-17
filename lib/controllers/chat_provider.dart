import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../models/response/chats/get_chat_res_model.dart';
import '../services/helper/chat_helper.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  String? userId;
  List<String> _online = [];

  bool _typing = false;

  bool get typing => _typing;

  set typingStatus(bool newStatus) {
    _typing = newStatus;
    notifyListeners();
  }

  List<String> get online => _online;

  set onlineUsers(List<String> newUser) {
    _online = newUser;
    notifyListeners();
  }

  getChat() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    print(userId);
  }

  String msgTime(String timeStamp) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timeStamp);

    messageTime = messageTime
        .toLocal(); // this will convert any time to local like if getting the time in UTC time zone, then this will convert in ITC (india time zone)

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.year &&
        now.day - messageTime.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}
