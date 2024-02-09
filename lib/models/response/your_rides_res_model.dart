// To parse this JSON data, do
//
//     final yourCreatedRidesResModel = yourCreatedRidesResModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<YourCreatedRidesResModel> yourCreatedRidesResModelFromJson(String str) => List<YourCreatedRidesResModel>.from(json.decode(str).map((x) => YourCreatedRidesResModel.fromJson(x)));

String yourCreatedRidesResModelToJson(List<YourCreatedRidesResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YourCreatedRidesResModel {
  final String id;
  final String departure;
  final List<StopBy> stopBy;
  final String destination;
  final DateTime schedule;
  final String aboutRide;
  final bool directBooking;
  final int seatsOffering;
  final int seatsAvailable;
  final int pricePerPass;
  final Id driverId;
  final VehicleId vehicleId;
  final List<Id> passangersId;
  final bool isCanceled;
  final bool isFinished;

  YourCreatedRidesResModel({
    required this.id,
    required this.departure,
    required this.stopBy,
    required this.destination,
    required this.schedule,
    required this.aboutRide,
    required this.directBooking,
    required this.seatsOffering,
    required this.seatsAvailable,
    required this.pricePerPass,
    required this.driverId,
    required this.vehicleId,
    required this.passangersId,
    required this.isCanceled,
    required this.isFinished,
  });

  factory YourCreatedRidesResModel.fromJson(Map<String, dynamic> json) => YourCreatedRidesResModel(
    id: json["_id"],
    departure: json["departure"],
    stopBy: List<StopBy>.from(json["stopBy"].map((x) => StopBy.fromJson(x))),
    destination: json["destination"],
    schedule: DateTime.parse(json["schedule"]),
    aboutRide: json["aboutRide"],
    directBooking: json["directBooking"],
    seatsOffering: json["seatsOffering"],
    seatsAvailable: json["seatsAvailable"],
    pricePerPass: json["pricePerPass"],
    driverId: Id.fromJson(json["driverId"]),
    vehicleId: VehicleId.fromJson(json["vehicleId"]),
    passangersId: List<Id>.from(json["passangersId"].map((x) => Id.fromJson(x))),
    isCanceled: json["isCanceled"],
    isFinished: json["isFinished"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "departure": departure,
    "stopBy": List<dynamic>.from(stopBy.map((x) => x.toJson())),
    "destination": destination,
    "schedule": schedule.toIso8601String(),
    "aboutRide": aboutRide,
    "directBooking": directBooking,
    "seatsOffering": seatsOffering,
    "seatsAvailable": seatsAvailable,
    "pricePerPass": pricePerPass,
    "driverId": driverId.toJson(),
    "vehicleId": vehicleId.toJson(),
    "passangersId": List<dynamic>.from(passangersId.map((x) => x.toJson())),
    "isCanceled": isCanceled,
    "isFinished": isFinished,
  };
}

class Id {
  final IdentityDocument identityDocument;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String id;
  final String miniBio;

  Id({
    required this.identityDocument,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.id,
    required this.miniBio,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
    id: json["_id"],
    miniBio: json["miniBio"],
  );

  Map<String, dynamic> toJson() => {
    "identityDocument": identityDocument.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "email": email,
    "profile": profile,
    "_id": id,
    "miniBio": miniBio,
  };
}

class IdentityDocument {
  final String documentType;
  final String documentImg;

  IdentityDocument({
    required this.documentType,
    required this.documentImg,
  });

  factory IdentityDocument.fromJson(Map<String, dynamic> json) => IdentityDocument(
    documentType: json["documentType"],
    documentImg: json["documentImg"],
  );

  Map<String, dynamic> toJson() => {
    "documentType": documentType,
    "documentImg": documentImg,
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

class VehicleId {
  final String id;
  final String userId;
  final String type;
  final String image;
  final String model;
  final String registrationNumber;
  final int offeringSeat;
  final String makeAndCategory;
  final String features;
  final String exception;
  final bool isDefault;
  final bool requiredHelmet;

  VehicleId({
    required this.id,
    required this.userId,
    required this.type,
    required this.image,
    required this.model,
    required this.registrationNumber,
    required this.offeringSeat,
    required this.makeAndCategory,
    required this.features,
    required this.exception,
    required this.isDefault,
    required this.requiredHelmet,
  });

  factory VehicleId.fromJson(Map<String, dynamic> json) => VehicleId(
    id: json["_id"],
    userId: json["userId"],
    type: json["type"],
    image: json["image"],
    model: json["model"],
    registrationNumber: json["registrationNumber"],
    offeringSeat: json["offeringSeat"],
    makeAndCategory: json["makeAndCategory"],
    features: json["features"],
    exception: json["exception"],
    isDefault: json["isDefault"],
    requiredHelmet: json["requiredHelmet"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "type": type,
    "image": image,
    "model": model,
    "registrationNumber": registrationNumber,
    "offeringSeat": offeringSeat,
    "makeAndCategory": makeAndCategory,
    "features": features,
    "exception": exception,
    "isDefault": isDefault,
    "requiredHelmet": requiredHelmet,
  };
}
