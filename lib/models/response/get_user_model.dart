// To parse this JSON data, do
//
//     final getUser = getUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUser getUserFromJson(String str) => GetUser.fromJson(json.decode(str));

String getUserToJson(GetUser data) => json.encode(data.toJson());

class GetUser {
  final IdentityDocument identityDocument;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String miniBio;
  final List<Vehicle> vehicles;
  final List<dynamic> createdRide;
  final List<dynamic> requestedRide;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String oneSignalId;

  GetUser({
    required this.identityDocument,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.miniBio,
    required this.vehicles,
    required this.createdRide,
    required this.requestedRide,
    required this.createdAt,
    required this.updatedAt,
    required this.oneSignalId,
  });

  factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
    miniBio: json["miniBio"],
    vehicles: List<Vehicle>.from(json["vehicles"].map((x) => Vehicle.fromJson(x))),
    createdRide: List<dynamic>.from(json["createdRide"].map((x) => x)),
    requestedRide: List<dynamic>.from(json["requestedRide"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    oneSignalId: json["oneSignalId"],
  );

  Map<String, dynamic> toJson() => {
    "identityDocument": identityDocument.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "email": email,
    "profile": profile,
    "miniBio": miniBio,
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
    "createdRide": List<dynamic>.from(createdRide.map((x) => x)),
    "requestedRide": List<dynamic>.from(requestedRide.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "oneSignalId": oneSignalId,
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

class Vehicle {
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
  final DateTime createdAt;
  final DateTime updatedAt;

  Vehicle({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
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
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
