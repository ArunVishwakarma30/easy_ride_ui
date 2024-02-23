import 'dart:convert';

RequestRideReqModel requestRideReqModelFromJson(String str) => RequestRideReqModel.fromJson(json.decode(str));

String requestRideReqModelToJson(RequestRideReqModel data) => json.encode(data.toJson());

class RequestRideReqModel {
  final String rideId;
  final String userId;
  final int seatsRequired;
  final bool? isAccepted;

  RequestRideReqModel({
    required this.rideId,
    required this.userId,
    required this.seatsRequired,
    this.isAccepted,
  });

  factory RequestRideReqModel.fromJson(Map<String, dynamic> json) => RequestRideReqModel(
    rideId: json["rideId"],
    userId: json["userId"],
    seatsRequired: json["seatsRequired"],
    isAccepted: json["isAccepted"],
  );

  Map<String, dynamic> toJson() => {
    "rideId": rideId,
    "userId": userId,
    "seatsRequired": seatsRequired,
    "isAccepted": isAccepted,
  };
}
