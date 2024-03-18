// To parse this JSON data, do
//
//     final verifyOtpReqModel = verifyOtpReqModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

VerifyOtpReqModel verifyOtpReqModelFromJson(String str) => VerifyOtpReqModel.fromJson(json.decode(str));

String verifyOtpReqModelToJson(VerifyOtpReqModel data) => json.encode(data.toJson());

class VerifyOtpReqModel {
  final String email;
  final String otp;
  final String hash;

  VerifyOtpReqModel({
    required this.email,
    required this.otp,
    required this.hash,
  });

  factory VerifyOtpReqModel.fromJson(Map<String, dynamic> json) => VerifyOtpReqModel(
    email: json["email"],
    otp: json["otp"],
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
    "hash": hash,
  };
}
