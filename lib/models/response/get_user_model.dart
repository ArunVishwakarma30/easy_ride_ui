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
  final List<dynamic> vehicles;
  final List<dynamic> createdRide;
  final List<dynamic> requestedRide;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    vehicles: List<dynamic>.from(json["vehicles"].map((x) => x)),
    createdRide: List<dynamic>.from(json["createdRide"].map((x) => x)),
    requestedRide: List<dynamic>.from(json["requestedRide"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "createdRide": List<dynamic>.from(createdRide.map((x) => x)),
    "requestedRide": List<dynamic>.from(requestedRide.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
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
