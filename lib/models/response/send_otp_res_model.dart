import 'dart:convert';

SendOtpResModel sendOtpResModelFromJson(String str) => SendOtpResModel.fromJson(json.decode(str));

String sendOtpResModelToJson(SendOtpResModel data) => json.encode(data.toJson());

class SendOtpResModel {
  final String message;
  final String data;

  SendOtpResModel({
    required this.message,
    required this.data,
  });

  factory SendOtpResModel.fromJson(Map<String, dynamic> json) => SendOtpResModel(
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data,
  };
}
