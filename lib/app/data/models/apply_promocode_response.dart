// To parse this JSON data, do
//
//     final applyPromoCodeResponse = applyPromoCodeResponseFromJson(jsonString);

import 'dart:convert';

ApplyPromoCodeResponse applyPromoCodeResponseFromJson(String str) =>
    ApplyPromoCodeResponse.fromJson(json.decode(str));

String applyPromoCodeResponseToJson(ApplyPromoCodeResponse data) =>
    json.encode(data.toJson());

class ApplyPromoCodeResponse {
  ApplyPromoCodeResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  Data data;

  factory ApplyPromoCodeResponse.fromJson(Map<String, dynamic> json) =>
      ApplyPromoCodeResponse(
        status: json["status"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.code,
    this.type,
    this.value,
    this.image,
    this.description,
    this.cartValue,
    this.expiryDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String code;
  String type;
  int value;
  String image;
  String description;
  int cartValue;
  DateTime expiryDate;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        code: json["code"],
        type: json["type"],
        value: json["value"],
        image: json["image"],
        description: json["description"],
        cartValue: json["cart_value"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "type": type,
        "value": value,
        "image": image,
        "description": description,
        "cart_value": cartValue,
        "expiry_date":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final invalidPromoCodeResponse = invalidPromoCodeResponseFromJson(jsonString);

InvalidPromoCodeResponse invalidPromoCodeResponseFromJson(String str) => InvalidPromoCodeResponse.fromJson(json.decode(str));

String invalidPromoCodeResponseToJson(InvalidPromoCodeResponse data) => json.encode(data.toJson());

class InvalidPromoCodeResponse {
    InvalidPromoCodeResponse({
        this.status,
        this.msg,
    });

    bool status;
    String msg;

    factory InvalidPromoCodeResponse.fromJson(Map<String, dynamic> json) => InvalidPromoCodeResponse(
        status: json["status"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
    };
}
