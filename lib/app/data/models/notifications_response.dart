// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  NotificationResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  List<NotificationList> data;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationList {
  NotificationList({
    this.id,
    this.userId,
    this.message,
    this.deepLink,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String message;
  dynamic deepLink;
  String isRead;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
        id: json["id"],
        userId: json["user_id"],
        message: json["message"],
        deepLink: json["deep_link"],
        isRead: json["is_read"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "message": message,
        "deep_link": deepLink,
        "is_read": isRead,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
