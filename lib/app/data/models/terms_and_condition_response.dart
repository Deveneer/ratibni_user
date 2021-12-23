// To parse this JSON data, do
//
//     final termsAndConditionResponse = termsAndConditionResponseFromJson(jsonString);

import 'dart:convert';

TermsAndConditionResponse termsAndConditionResponseFromJson(String str) =>
    TermsAndConditionResponse.fromJson(json.decode(str));

String termsAndConditionResponseToJson(TermsAndConditionResponse data) =>
    json.encode(data.toJson());

class TermsAndConditionResponse {
  TermsAndConditionResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  Data data;

  factory TermsAndConditionResponse.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionResponse(
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
    this.termAndConditionId,
    this.termAndCondition,
    this.createdAt,
    this.updatedAt,
  });

  int termAndConditionId;
  String termAndCondition;
  dynamic createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        termAndConditionId: json["term_and_condition_id"],
        termAndCondition: json["term_and_condition"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "term_and_condition_id": termAndConditionId,
        "term_and_condition": termAndCondition,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
      };
}
