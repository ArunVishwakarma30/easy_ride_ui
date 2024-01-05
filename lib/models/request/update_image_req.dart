import 'dart:convert';

UpdateProfileImageReq updateProfileImageReqFromJson(String str) =>
    UpdateProfileImageReq.fromJson(json.decode(str));

String updateProfileImageReqToJson(UpdateProfileImageReq data) =>
    json.encode(data.toJson());

class UpdateProfileImageReq {
  final String profile;

  UpdateProfileImageReq({
    required this.profile,
  });

  factory UpdateProfileImageReq.fromJson(Map<String, dynamic> json) =>
      UpdateProfileImageReq(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
      };
}
