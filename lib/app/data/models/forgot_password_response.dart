// To parse this JSON data, do
//
//     final forgotPasswordResponse = forgotPasswordResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) =>
    ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  Data data;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
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
    this.otp,
    this.phoneNo,
    this.email,
    this.apiToken,
  });

  int otp;
  String phoneNo;
  String email;
  String apiToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otp: json["otp"],
        phoneNo: json["phone_no"],
        email: json["email"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "phone_no": phoneNo,
        "email": email,
        "api_token": apiToken,
      };
}
