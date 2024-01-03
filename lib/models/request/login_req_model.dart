import 'dart:convert';

LoginReqModel loginReqModelFromJson(String str) =>
    LoginReqModel.fromJson(json.decode(str));

String loginReqModelToJson(LoginReqModel data) => json.encode(data.toJson());

class LoginReqModel {
  final String email;
  final String password;

  LoginReqModel({
    required this.email,
    required this.password,
  });

  factory LoginReqModel.fromJson(Map<String, dynamic> json) => LoginReqModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
