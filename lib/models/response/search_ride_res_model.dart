import 'dart:convert';

List<SearchRidesResModel> searchRidesResModelFromJson(String str) => List<SearchRidesResModel>.from(json.decode(str).map((x) => SearchRidesResModel.fromJson(x)));

String searchRidesResModelToJson(List<SearchRidesResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchRidesResModel {
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
  final DriverId driverId;
  final VehicleId vehicleId;
  final List<dynamic> passangersId;
  final List<String> requests;
  final bool isCanceled;
  final bool isFinished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SearchRidesResModel({
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
    required this.requests,
    required this.isCanceled,
    required this.isFinished,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SearchRidesResModel.fromJson(Map<String, dynamic> json) => SearchRidesResModel(
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
    driverId: DriverId.fromJson(json["driverId"]),
    vehicleId: VehicleId.fromJson(json["vehicleId"]),
    passangersId: List<PassangersId>.from(json["passangersId"].map((x) => PassangersId.fromJson(x))),
    requests: List<String>.from(json["requests"].map((x) => x)),
    isCanceled: json["isCanceled"],
    isFinished: json["isFinished"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
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
    "requests": List<dynamic>.from(requests.map((x) => x)),
    "isCanceled": isCanceled,
    "isFinished": isFinished,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class DriverId {
  final IdentityDocument identityDocument;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String miniBio;
  final List<String> vehicles;
  final String oneSignalId;

  DriverId({
    required this.identityDocument,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.miniBio,
    required this.vehicles,
    required this.oneSignalId,
  });

  factory DriverId.fromJson(Map<String, dynamic> json) => DriverId(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
    miniBio: json["miniBio"],
    vehicles: List<String>.from(json["vehicles"].map((x) => x)),
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
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
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

class PassangersId {
  final IdentityDocument identityDocument;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String miniBio;
  final String oneSignalId;
  final String password;
  final List<String> vehicles;
  final List<String> createdRide;
  final List<String> requestedRide;
  final DateTime createdAt;
  final DateTime updatedAt;

  PassangersId({
    required this.identityDocument,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.miniBio,
    required this.oneSignalId,
    required this.password,
    required this.vehicles,
    required this.createdRide,
    required this.requestedRide,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PassangersId.fromJson(Map<String, dynamic> json) => PassangersId(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
    miniBio: json["miniBio"],
    oneSignalId: json["oneSignalId"],
    password: json["password"],
    vehicles: List<String>.from(json["vehicles"].map((x) => x)),
    createdRide: List<String>.from(json["createdRide"].map((x) => x)),
    requestedRide: List<String>.from(json["requestedRide"].map((x) => x)),
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
    "oneSignalId": oneSignalId,
    "password": password,
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "createdRide": List<dynamic>.from(createdRide.map((x) => x)),
    "requestedRide": List<dynamic>.from(requestedRide.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class StopBy {
  final String gMapAddressId;
  final String address;
  final String id;

  StopBy({
    required this.gMapAddressId,
    required this.address,
    required this.id,
  });

  factory StopBy.fromJson(Map<String, dynamic> json) => StopBy(
    gMapAddressId: json["gMapAddressId"],
    address: json["address"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "gMapAddressId": gMapAddressId,
    "address": address,
    "_id": id,
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
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
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
