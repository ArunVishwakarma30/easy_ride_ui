import 'dart:convert';

SignUpReqModel signUpReqModelFromJson(String str) => SignUpReqModel.fromJson(json.decode(str));

String signUpReqModelToJson(SignUpReqModel data) => json.encode(data.toJson());

class SignUpReqModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  SignUpReqModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) => SignUpReqModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
  };
}
