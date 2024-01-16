import 'dart:convert';

List<SearchRidesResModel> searchRidesResModelFromJson(String str) =>
    List<SearchRidesResModel>.from(
        json.decode(str).map((x) => SearchRidesResModel.fromJson(x)));

String searchRidesResModelToJson(List<SearchRidesResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchRidesResModel {
  final String id;
  final String departure;
  final List<String> stopBy;
  final String destination;
  final DateTime schedule;
  final int seatsOffering;
  final int seatsAvailable;
  final DriverId driverId;
  final VehicleId vehicleId;
  final List<dynamic> passangersId;
  final bool isCanceled;
  final bool isFinished;
  final int pricePerPass;

  SearchRidesResModel({
    required this.id,
    required this.departure,
    required this.stopBy,
    required this.destination,
    required this.schedule,
    required this.seatsOffering,
    required this.seatsAvailable,
    required this.driverId,
    required this.vehicleId,
    required this.passangersId,
    required this.isCanceled,
    required this.isFinished,
    required this.pricePerPass,
  });

  factory SearchRidesResModel.fromJson(Map<String, dynamic> json) =>
      SearchRidesResModel(
        id: json["_id"],
        departure: json["departure"],
        stopBy: List<String>.from(json["stopBy"].map((x) => x)),
        destination: json["destination"],
        schedule: DateTime.parse(json["schedule"]),
        seatsOffering: json["seatsOffering"],
        seatsAvailable: json["seatsAvailable"],
        driverId: DriverId.fromJson(json["driverId"]),
        vehicleId: VehicleId.fromJson(json["vehicleId"]),
        passangersId: List<dynamic>.from(json["passangersId"].map((x) => x)),
        isCanceled: json["isCanceled"],
        isFinished: json["isFinished"],
        pricePerPass: json["pricePerPass"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "departure": departure,
        "stopBy": List<dynamic>.from(stopBy.map((x) => x)),
        "destination": destination,
        "schedule": schedule.toIso8601String(),
        "seatsOffering": seatsOffering,
        "seatsAvailable": seatsAvailable,
        "driverId": driverId.toJson(),
        "vehicleId": vehicleId.toJson(),
        "passangersId": List<dynamic>.from(passangersId.map((x) => x)),
        "isCanceled": isCanceled,
        "isFinished": isFinished,
        "pricePerPass": pricePerPass,
      };
}

class DriverId {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String miniBio;

  DriverId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.miniBio,
  });

  factory DriverId.fromJson(Map<String, dynamic> json) => DriverId(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        profile: json["profile"],
        miniBio: json["miniBio"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "profile": profile,
        "miniBio": miniBio,
      };
}

class VehicleId {
  final String id;
  final String type;
  final String image;
  final String model;
  final String registrationNumber;
  final String makeAndCategory;
  final String features;
  final String exception;
  final bool requiredHelmet;

  VehicleId({
    required this.id,
    required this.type,
    required this.image,
    required this.model,
    required this.registrationNumber,
    required this.makeAndCategory,
    required this.features,
    required this.exception,
    required this.requiredHelmet,
  });

  factory VehicleId.fromJson(Map<String, dynamic> json) => VehicleId(
        id: json["_id"],
        type: json["type"],
        image: json["image"],
        model: json["model"],
        registrationNumber: json["registrationNumber"],
        makeAndCategory: json["makeAndCategory"],
        features: json["features"],
        exception: json["exception"],
        requiredHelmet: json["requiredHelmet"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "image": image,
        "model": model,
        "registrationNumber": registrationNumber,
        "makeAndCategory": makeAndCategory,
        "features": features,
        "exception": exception,
        "requiredHelmet": requiredHelmet,
      };
}
