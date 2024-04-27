import 'dart:convert';

FinishRideReq finishRideReqFromJson(String str) => FinishRideReq.fromJson(json.decode(str));

String finishRideReqToJson(FinishRideReq data) => json.encode(data.toJson());

class FinishRideReq {
  final DateTime endTime;
  final bool isFinished;
  final bool isStarted;

  FinishRideReq({
    required this.endTime,
    required this.isFinished,
    required this.isStarted,
  });

  factory FinishRideReq.fromJson(Map<String, dynamic> json) => FinishRideReq(
    endTime: DateTime.parse(json["endTime"]),
    isFinished: json["isFinished"],
    isStarted: json["isStarted"],
  );

  Map<String, dynamic> toJson() => {
    "endTime": endTime.toIso8601String(),
    "isFinished": isFinished,
    "isStarted": isStarted,
  };
}
