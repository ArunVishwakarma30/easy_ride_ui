import 'dart:convert';

List<RequestedRidesResModel> requestedRidesResModelFromJson(String str) => List<RequestedRidesResModel>.from(json.decode(str).map((x) => RequestedRidesResModel.fromJson(x)));

String requestedRidesResModelToJson(List<RequestedRidesResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestedRidesResModel {
  final String id;
  final RideId rideId;
  final UserId userId;
  final int seatsRequired;
  final dynamic isAccepted;
  final bool isCanceled;
  final bool isFinished;

  RequestedRidesResModel({
    required this.id,
    required this.rideId,
    required this.userId,
    required this.seatsRequired,
    required this.isAccepted,
    required this.isCanceled,
    required this.isFinished,
  });

  factory RequestedRidesResModel.fromJson(Map<String, dynamic> json) => RequestedRidesResModel(
    id: json["_id"],
    rideId: RideId.fromJson(json["rideId"]),
    userId: UserId.fromJson(json["userId"]),
    seatsRequired: json["seatsRequired"],
    isAccepted: json["isAccepted"],
    isCanceled: json["isCanceled"],
    isFinished: json["isFinished"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rideId": rideId.toJson(),
    "userId": userId.toJson(),
    "seatsRequired": seatsRequired,
    "isAccepted": isAccepted,
    "isCanceled": isCanceled,
    "isFinished": isFinished,
  };
}

class RideId {
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
  final String driverId;
  final String vehicleId;
  final List<String> passangersId;
  final bool isCanceled;
  final bool isFinished;

  RideId({
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

  factory RideId.fromJson(Map<String, dynamic> json) => RideId(
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
    driverId: json["driverId"],
    vehicleId: json["vehicleId"],
    passangersId: List<String>.from(json["passangersId"].map((x) => x)),
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
    "driverId": driverId,
    "vehicleId": vehicleId,
    "passangersId": List<dynamic>.from(passangersId.map((x) => x)),
    "isCanceled": isCanceled,
    "isFinished": isFinished,
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

class UserId {
  final IdentityDocument identityDocument;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profile;
  final String miniBio;
  final String oneSignalId;

  UserId({
    required this.identityDocument,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profile,
    required this.miniBio,
    required this.oneSignalId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    profile: json["profile"],
    miniBio: json["miniBio"],
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
