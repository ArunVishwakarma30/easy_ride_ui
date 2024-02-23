import 'dart:convert';

SendNotificationReqModel sendNotificationReqModelFromJson(String str) => SendNotificationReqModel.fromJson(json.decode(str));

String sendNotificationReqModelToJson(SendNotificationReqModel data) => json.encode(data.toJson());

class SendNotificationReqModel {
  final List<String> devices;
  final String content;

  SendNotificationReqModel({
    required this.devices,
    required this.content,
  });

  factory SendNotificationReqModel.fromJson(Map<String, dynamic> json) => SendNotificationReqModel(
    devices: List<String>.from(json["devices"].map((x) => x)),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "devices": List<dynamic>.from(devices.map((x) => x)),
    "content": content,
  };
}
