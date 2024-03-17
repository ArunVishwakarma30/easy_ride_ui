// To parse this JSON data, do
//
//     final receivedMessage = receivedMessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ReceivedMessage> receivedMessageFromJson(String str) => List<ReceivedMessage>.from(json.decode(str).map((x) => ReceivedMessage.fromJson(x)));

String receivedMessageToJson(List<ReceivedMessage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceivedMessage {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final dynamic chatId;
  final List<dynamic> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReceivedMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chatId,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReceivedMessage.fromJson(Map<String, dynamic> json) => ReceivedMessage(
    id: json["_id"],
    sender: Sender.fromJson(json["sender"]),
    content: json["content"],
    receiver: json["receiver"],
    chatId: json["chatId"],
    readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "sender": sender.toJson(),
    "content": content,
    "receiver": receiver,
    "chatId": chatId,
    "readBy": List<dynamic>.from(readBy.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Sender {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "email": email,
    "profile": profile,
  };
}
