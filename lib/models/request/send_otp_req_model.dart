
import 'package:meta/meta.dart';
import 'dart:convert';

SendOtpReqModel sendOtpReqModelFromJson(String str) => SendOtpReqModel.fromJson(json.decode(str));

String sendOtpReqModelToJson(SendOtpReqModel data) => json.encode(data.toJson());

class SendOtpReqModel {
  final String email;

  SendOtpReqModel({
    required this.email,
  });

  factory SendOtpReqModel.fromJson(Map<String, dynamic> json) => SendOtpReqModel(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
