import 'package:meta/meta.dart';
import 'dart:convert';

CreateChat createChatFromJson(String str) => CreateChat.fromJson(json.decode(str));

String createChatToJson(CreateChat data) => json.encode(data.toJson());

class CreateChat {
  final String senderId;
  final String receiverId;

  CreateChat({
    required this.senderId,
    required this.receiverId,
  });

  factory CreateChat.fromJson(Map<String, dynamic> json) => CreateChat(
    senderId: json["senderId"],
    receiverId: json["receiverId"],
  );

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "receiverId": receiverId,
  };
}
