// To parse this JSON data, do
//
//     final privacyPolicyResponse = privacyPolicyResponseFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyResponse privacyPolicyResponseFromJson(String str) =>
    PrivacyPolicyResponse.fromJson(json.decode(str));

String privacyPolicyResponseToJson(PrivacyPolicyResponse data) =>
    json.encode(data.toJson());

class PrivacyPolicyResponse {
  PrivacyPolicyResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  Data data;

  factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyResponse(
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
    this.privacyPolicyId,
    this.privacyPolicy,
    this.createdAt,
    this.updatedAt,
  });

  int privacyPolicyId;
  String privacyPolicy;
  dynamic createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        privacyPolicyId: json["privacy_policy_id"],
        privacyPolicy: json["privacy_policy"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "privacy_policy_id": privacyPolicyId,
        "privacy_policy": privacyPolicy,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
