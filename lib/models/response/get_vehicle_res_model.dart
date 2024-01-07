import 'dart:convert';

List<GetVehicleResModel> getVehicleResModelFromJson(String str) => List<GetVehicleResModel>.from(json.decode(str).map((x) => GetVehicleResModel.fromJson(x)));

String getVehicleResModelToJson(List<GetVehicleResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetVehicleResModel {
  final String id;
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

  GetVehicleResModel({
    required this.id,
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

  factory GetVehicleResModel.fromJson(Map<String, dynamic> json) => GetVehicleResModel(
    id: json["_id"],
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
