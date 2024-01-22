// To parse this JSON data, do
//
//     final createRideReqModel = createRideReqModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateRideReqModel createRideReqModelFromJson(String str) => CreateRideReqModel.fromJson(json.decode(str));

String createRideReqModelToJson(CreateRideReqModel data) => json.encode(data.toJson());

class CreateRideReqModel {
  final String departure;
  final String destination;
  final DateTime schedule;
  final String aboutRide;
  final bool directBooking;
  final List<StopBy> stopBy;
  final int seatsOffering;
  final int seatsAvailable;
  final String driverId;
  final String vehicleId;
  final int pricePerPass;

  CreateRideReqModel({
    required this.departure,
    required this.destination,
    required this.schedule,
    required this.aboutRide,
    required this.directBooking,
    required this.stopBy,
    required this.seatsOffering,
    required this.seatsAvailable,
    required this.driverId,
    required this.vehicleId,
    required this.pricePerPass,
  });

  factory CreateRideReqModel.fromJson(Map<String, dynamic> json) => CreateRideReqModel(
    departure: json["departure"],
    destination: json["destination"],
    schedule: DateTime.parse(json["schedule"]),
    aboutRide: json["aboutRide"],
    directBooking: json["directBooking"],
    stopBy: List<StopBy>.from(json["stopBy"].map((x) => StopBy.fromJson(x))),
    seatsOffering: json["seatsOffering"],
    seatsAvailable: json["seatsAvailable"],
    driverId: json["driverId"],
    vehicleId: json["vehicleId"],
    pricePerPass: json["pricePerPass"],
  );

  Map<String, dynamic> toJson() => {
    "departure": departure,
    "destination": destination,
    "schedule": schedule.toIso8601String(),
    "aboutRide": aboutRide,
    "directBooking": directBooking,
    "stopBy": List<dynamic>.from(stopBy.map((x) => x.toJson())),
    "seatsOffering": seatsOffering,
    "seatsAvailable": seatsAvailable,
    "driverId": driverId,
    "vehicleId": vehicleId,
    "pricePerPass": pricePerPass,
  };
}

class StopBy {
  final String gMapAddressId;
  final String address;

  StopBy({
    required this.gMapAddressId,
    required this.address,
  });

  factory StopBy.fromJson(Map<String, dynamic> json) => StopBy(
    gMapAddressId: json["gMapAddressId"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "gMapAddressId": gMapAddressId,
    "address": address,
  };
}
