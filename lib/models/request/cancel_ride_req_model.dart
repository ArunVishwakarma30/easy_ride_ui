import 'dart:convert';

CancelRideReqModel cancelRideReqModelFromJson(String str) => CancelRideReqModel.fromJson(json.decode(str));

String cancelRideReqModelToJson(CancelRideReqModel data) => json.encode(data.toJson());

class CancelRideReqModel {
  final bool isCanceled;

  CancelRideReqModel({
    required this.isCanceled,
  });

  factory CancelRideReqModel.fromJson(Map<String, dynamic> json) => CancelRideReqModel(
    isCanceled: json["isCanceled"],
  );

  Map<String, dynamic> toJson() => {
    "isCanceled": isCanceled,
  };
}
