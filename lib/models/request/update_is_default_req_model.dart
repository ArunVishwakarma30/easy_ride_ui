// To parse this JSON data, do
//
//     final updateIsDefaultReq = updateIsDefaultReqFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateIsDefaultReq updateIsDefaultReqFromJson(String str) => UpdateIsDefaultReq.fromJson(json.decode(str));

String updateIsDefaultReqToJson(UpdateIsDefaultReq data) => json.encode(data.toJson());

class UpdateIsDefaultReq {
  final String userId;
  final bool isDefault;

  UpdateIsDefaultReq({
    required this.userId,
    required this.isDefault,
  });

  factory UpdateIsDefaultReq.fromJson(Map<String, dynamic> json) => UpdateIsDefaultReq(
    userId: json["userId"],
    isDefault: json["isDefault"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "isDefault": isDefault,
  };
}
