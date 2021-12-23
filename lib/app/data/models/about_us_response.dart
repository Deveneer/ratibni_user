// To parse this JSON data, do
//
//     final aboutUsResponse = aboutUsResponseFromJson(jsonString);

import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

String aboutUsResponseToJson(AboutUsResponse data) =>
    json.encode(data.toJson());

class AboutUsResponse {
  AboutUsResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  Data data;

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.aboutId,
    this.aboutTitle,
    this.aboutImage,
    this.aboutDescription,
    this.createdAt,
    this.updatedAt,
  });

  int aboutId;
  String aboutTitle;
  String aboutImage;
  String aboutDescription;
  dynamic createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aboutId: json["about_id"],
        aboutTitle: json["about_title"],
        aboutImage: json["about_image"],
        aboutDescription: json["about_description"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "about_id": aboutId,
        "about_title": aboutTitle,
        "about_image": aboutImage,
        "about_description": aboutDescription,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
