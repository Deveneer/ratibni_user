// To parse this JSON data, do
//
//     final cancelBookingReasonsResponse = cancelBookingReasonsResponseFromJson(jsonString);

import 'dart:convert';

CancelBookingReasonsResponse cancelBookingReasonsResponseFromJson(String str) =>
    CancelBookingReasonsResponse.fromJson(json.decode(str));

String cancelBookingReasonsResponseToJson(CancelBookingReasonsResponse data) =>
    json.encode(data.toJson());

class CancelBookingReasonsResponse {
  CancelBookingReasonsResponse({
    this.the0,
    this.status,
    this.data,
  });

  String the0;
  bool status;
  List<CancelReason> data;

  factory CancelBookingReasonsResponse.fromJson(Map<String, dynamic> json) =>
      CancelBookingReasonsResponse(
        the0: json["0"],
        status: json["status"],
        data: List<CancelReason>.from(json["data"].map((x) => CancelReason.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "0": the0,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CancelReason {
  CancelReason({
    this.id,
    this.reason,
    this.userType,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String reason;
  int userType;
  int isActive;
  dynamic createdAt;
  dynamic updatedAt;

  factory CancelReason.fromJson(Map<String, dynamic> json) => CancelReason(
        id: json["id"],
        reason: json["reason"],
        userType: json["user_type"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "user_type": userType,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
