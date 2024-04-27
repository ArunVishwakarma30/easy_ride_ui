import 'package:meta/meta.dart';
import 'dart:convert';

StartRideReq startRideReqFromJson(String str) => StartRideReq.fromJson(json.decode(str));

String startRideReqToJson(StartRideReq data) => json.encode(data.toJson());

class StartRideReq {
  final DateTime startTime;
  final bool isStarted;

  StartRideReq({
    required this.startTime,
    required this.isStarted,
  });

  factory StartRideReq.fromJson(Map<String, dynamic> json) => StartRideReq(
    startTime: DateTime.parse(json["startTime"]),
    isStarted: json["isStarted"],
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime.toIso8601String(),
    "isStarted": isStarted,
  };
}
