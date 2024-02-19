import 'dart:convert';

UpdateOneSignalIdReq updateOneSignalIdReqFromJson(String str) =>
    UpdateOneSignalIdReq.fromJson(json.decode(str));

String updateOneSignalIdReqToJson(UpdateOneSignalIdReq data) =>
    json.encode(data.toJson());

class UpdateOneSignalIdReq {
  final String oneSignalId;

  UpdateOneSignalIdReq({
    required this.oneSignalId,
  });

  factory UpdateOneSignalIdReq.fromJson(Map<String, dynamic> json) =>
      UpdateOneSignalIdReq(
        oneSignalId: json["oneSignalId"],
      );

  Map<String, dynamic> toJson() => {
        "oneSignalId": oneSignalId,
      };
}
