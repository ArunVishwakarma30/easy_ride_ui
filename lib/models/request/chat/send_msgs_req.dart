// To parse this JSON data, do
//
//     final sendMessage = sendMessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SendMessage sendMessageFromJson(String str) => SendMessage.fromJson(json.decode(str));

String sendMessageToJson(SendMessage data) => json.encode(data.toJson());

class SendMessage {
  final String content;
  final String chatId;
  final String senderId;
  final String receiver;

  SendMessage({
    required this.content,
    required this.chatId,
    required this.senderId,
    required this.receiver,
  });

  factory SendMessage.fromJson(Map<String, dynamic> json) => SendMessage(
    content: json["content"],
    chatId: json["chatId"],
    senderId: json["senderId"],
    receiver: json["receiver"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
    "chatId": chatId,
    "senderId": senderId,
    "receiver": receiver,
  };
}
