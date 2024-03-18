import 'dart:convert';

GetCreatedChats getCreatedChatsFromJson(String str) => GetCreatedChats.fromJson(json.decode(str));

String getCreatedChatsToJson(GetCreatedChats data) => json.encode(data.toJson());

class GetCreatedChats {
  final String id;
  final String chatName;
  final List<User> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  GetCreatedChats({
    required this.id,
    required this.chatName,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetCreatedChats.fromJson(Map<String, dynamic> json) => GetCreatedChats(
    id: json["_id"],
    chatName: json["chatName"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatName": chatName,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class User {
  final IdentityDocument identityDocument;
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String oneSignalId;
  final String email;
  final String profile;
  final String miniBio;
  final List<dynamic> vehicles;
  final List<dynamic> createdRide;
  final List<String> requestedRide;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  User({
    required this.identityDocument,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.oneSignalId,
    required this.email,
    required this.profile,
    required this.miniBio,
    required this.vehicles,
    required this.createdRide,
    required this.requestedRide,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    oneSignalId: json["oneSignalId"],
    email: json["email"],
    profile: json["profile"],
    miniBio: json["miniBio"],
    vehicles: List<dynamic>.from(json["vehicles"].map((x) => x)),
    createdRide: List<dynamic>.from(json["createdRide"].map((x) => x)),
    requestedRide: List<String>.from(json["requestedRide"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "identityDocument": identityDocument.toJson(),
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "oneSignalId": oneSignalId,
    "email": email,
    "profile": profile,
    "miniBio": miniBio,
    "vehicles": List<dynamic>.from(vehicles.map((x) => x)),
    "createdRide": List<dynamic>.from(createdRide.map((x) => x)),
    "requestedRide": List<dynamic>.from(requestedRide.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
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
