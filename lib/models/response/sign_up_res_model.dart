import 'dart:convert';

SignUpResModel signUpResModelFromJson(String str) =>
    SignUpResModel.fromJson(json.decode(str));

String signUpResModelToJson(SignUpResModel data) => json.encode(data.toJson());

class SignUpResModel {
  final String id;
  final String userToken;

  SignUpResModel({
    required this.id,
    required this.userToken,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) => SignUpResModel(
        id: json["_id"],
        userToken: json["userToken"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userToken": userToken,
      };
}
