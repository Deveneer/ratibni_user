// To parse this JSON data, do
//
//     final serviceCategoriesResponse = serviceCategoriesResponseFromJson(jsonString);

import 'dart:convert';

ServiceCategoriesResponse serviceCategoriesResponseFromJson(String str) =>
    ServiceCategoriesResponse.fromJson(json.decode(str));

String serviceCategoriesResponseToJson(ServiceCategoriesResponse data) =>
    json.encode(data.toJson());

class ServiceCategoriesResponse {
  ServiceCategoriesResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  List<ServiceCategories> data;

  factory ServiceCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      ServiceCategoriesResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<ServiceCategories>.from(json["data"].map((x) => ServiceCategories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServiceCategories {
  ServiceCategories({
    this.id,
    this.name,
    this.description,
    this.iconImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  dynamic description;
  String iconImage;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory ServiceCategories.fromJson(Map<String, dynamic> json) => ServiceCategories(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        iconImage: json["icon_image"] == null ? null : json["icon_image"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon_image": iconImage == null ? null : iconImage,
        "status": status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
