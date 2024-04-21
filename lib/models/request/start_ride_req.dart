import 'package:meta/meta.dart';
import 'dart:convert';

StartRideReq startRideReqFromJson(String str) => StartRideReq.fromJson(json.decode(str));

String startRideReqToJson(StartRideReq data) => json.encode(data.toJson());

class StartRideReq {
  final DateTime startTime;

  StartRideReq({
    required this.startTime,
  });

  factory StartRideReq.fromJson(Map<String, dynamic> json) => StartRideReq(
    startTime: DateTime.parse(json["startTime"]),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime.toIso8601String(),
  };
}
