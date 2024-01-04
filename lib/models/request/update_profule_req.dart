// To parse this JSON data, do
//
//     final updateProfileReq = updateProfileReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateProfileReq updateProfileReqFromJson(String str) => UpdateProfileReq.fromJson(json.decode(str));

String updateProfileReqToJson(UpdateProfileReq data) => json.encode(data.toJson());

class UpdateProfileReq {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String miniBio;
  final String email;

  UpdateProfileReq({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.miniBio,
    required this.email,
  });

  factory UpdateProfileReq.fromJson(Map<String, dynamic> json) => UpdateProfileReq(
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    miniBio: json["miniBio"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "miniBio": miniBio,
    "email": email,
  };
}
