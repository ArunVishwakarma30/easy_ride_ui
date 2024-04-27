import 'dart:convert';

UploadIdentityModel uploadIdentityModelFromJson(String str) => UploadIdentityModel.fromJson(json.decode(str));

String uploadIdentityModelToJson(UploadIdentityModel data) => json.encode(data.toJson());

class UploadIdentityModel {
  final String firstName;
  final String lastName;
  final IdentityDocument identityDocument;

  UploadIdentityModel({
    required this.firstName,
    required this.lastName,
    required this.identityDocument,
  });

  factory UploadIdentityModel.fromJson(Map<String, dynamic> json) => UploadIdentityModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    identityDocument: IdentityDocument.fromJson(json["identityDocument"]),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "identityDocument": identityDocument.toJson(),
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
