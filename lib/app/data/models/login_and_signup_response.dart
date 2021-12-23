// To parse this JSON data, do
//
//     final loginAndSignUpResponse = loginAndSignUpResponseFromJson(jsonString);

import 'dart:convert';

LoginAndSignUpResponse loginAndSignUpResponseFromJson(String str) =>
    LoginAndSignUpResponse.fromJson(json.decode(str));

String loginAndSignUpResponseToJson(LoginAndSignUpResponse data) =>
    json.encode(data.toJson());

class LoginAndSignUpResponse {
  LoginAndSignUpResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  UserDetails data;

  factory LoginAndSignUpResponse.fromJson(Map<String, dynamic> json) =>
      LoginAndSignUpResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: UserDetails.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": data.toJson(),
      };
}

class UserDetails {
  UserDetails({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phoneNo,
    this.otp,
    this.image,
    this.emailVerifiedAt,
    this.apiToken,
    this.roleId,
    this.userType,
    this.companyId,
    this.experience,
    this.status,
    this.duty,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.loginAs,
    this.accessToken,
  });

  int id;
  String firstName;
  dynamic lastName;
  String email;
  dynamic countryCode;
  String phoneNo;
  int otp;
  dynamic image;
  dynamic emailVerifiedAt;
  String apiToken;
  int roleId;
  String userType;
  int companyId;
  int experience;
  int status;
  int duty;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic imageUrl;
  String loginAs;
  String accessToken;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        countryCode: json["country_code"],
        phoneNo: json["phone_no"],
        otp: json["otp"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        apiToken: json["api_token"],
        roleId: json["role_id"],
        userType: json["user_type"],
        companyId: json["company_id"],
        experience: json["experience"],
        status: json["status"],
        duty: json["duty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageUrl: json["image_url"],
        loginAs: json["login_as"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "country_code": countryCode,
        "phone_no": phoneNo,
        "otp": otp,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "api_token": apiToken,
        "role_id": roleId,
        "user_type": userType,
        "company_id": companyId,
        "experience": experience,
        "status": status,
        "duty": duty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image_url": imageUrl,
        "login_as": loginAs,
        "access_token": accessToken,
      };
}

// To parse this JSON data, do
//
//     final signupErrorResponse = signupErrorResponseFromJson(jsonString);

SignupErrorResponse signupErrorResponseFromJson(String str) =>
    SignupErrorResponse.fromJson(json.decode(str));

String signupErrorResponseToJson(SignupErrorResponse data) =>
    json.encode(data.toJson());

class SignupErrorResponse {
  SignupErrorResponse({
    this.errorCode,
    this.message,
  });

  int errorCode;
  String message;

  factory SignupErrorResponse.fromJson(Map<String, dynamic> json) =>
      SignupErrorResponse(
        errorCode: json["error_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
      };
}
