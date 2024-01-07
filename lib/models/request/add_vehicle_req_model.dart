import 'dart:convert';

AddVehicleReqModel addVehicleReqModelFromJson(String str) =>
    AddVehicleReqModel.fromJson(json.decode(str));

String addVehicleReqModelToJson(AddVehicleReqModel data) =>
    json.encode(data.toJson());

class AddVehicleReqModel {
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

  AddVehicleReqModel({
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

  factory AddVehicleReqModel.fromJson(Map<String, dynamic> json) =>
      AddVehicleReqModel(
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
