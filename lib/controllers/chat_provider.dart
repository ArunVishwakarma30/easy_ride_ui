import 'package:easy_ride/models/request/chat/create_chat_req.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../models/response/chats/get_chat_res_model.dart';
import '../services/helper/chat_helper.dart';
import '../views/ui/chat_screen.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  late GetChats createdChat;
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

  createChat(CreateChat model){
    ChatHelper.createChat(model).then((value) {
      if(value[0]==true){
        createdChat = value[1];
        Get.to(()=>ChatScreen(id: createdChat.chatName, title: createdChat.users[1].firstName, users: [createdChat.users[0].id, createdChat.users[1].id], ));
      }else{
        ShowSnackbar(title: "Failed", message: "Something Went Wrong", icon:Icons.error_outline_outlined);
      }
    });
  }
  getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
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
