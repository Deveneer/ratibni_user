// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'dart:convert';

AddressResponse addressResponseFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressResponseToJson(AddressResponse data) =>
    json.encode(data.toJson());

class AddressResponse {
  AddressResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  List<Address> data;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.country,
    this.state,
    this.city,
    this.zipcode,
    this.address,
    this.landmark,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String country;
  String state;
  String city;
  String zipcode;
  String address;
  String landmark;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        zipcode: json["zipcode"],
        address: json["address"],
        landmark: json["landmark"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "country": country,
        "state": state,
        "city": city,
        "zipcode": zipcode,
        "address": address,
        "landmark": landmark,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
