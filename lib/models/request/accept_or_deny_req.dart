import 'dart:convert';

AcceptOrDenyReq acceptOrDenyReqFromJson(String str) => AcceptOrDenyReq.fromJson(json.decode(str));

String acceptOrDenyReqToJson(AcceptOrDenyReq data) => json.encode(data.toJson());

class AcceptOrDenyReq {
  final bool isAccepted;

  AcceptOrDenyReq({
    required this.isAccepted,
  });

  factory AcceptOrDenyReq.fromJson(Map<String, dynamic> json) => AcceptOrDenyReq(
    isAccepted: json["isAccepted"],
  );

  Map<String, dynamic> toJson() => {
    "isAccepted": isAccepted,
  };
}
