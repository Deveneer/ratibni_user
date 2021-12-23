// To parse this JSON data, do
//
//     final serviceDetailsResponse = serviceDetailsResponseFromJson(jsonString);

import 'dart:convert';

ServiceDetailsResponse serviceDetailsResponseFromJson(String str) =>
    ServiceDetailsResponse.fromJson(json.decode(str));

String serviceDetailsResponseToJson(ServiceDetailsResponse data) =>
    json.encode(data.toJson());

class ServiceDetailsResponse {
  ServiceDetailsResponse({
    this.errorCode,
    this.message,
    this.data,
  });

  int errorCode;
  String message;
  List<ServiceDetails> data;

  factory ServiceDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsResponse(
        errorCode: json["error_code"],
        message: json["message"],
        data: List<ServiceDetails>.from(
            json["data"].map((x) => ServiceDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ServiceDetails {
  ServiceDetails({
    this.id,
    this.categoryId,
    this.categoryName,
    this.serviceName,
    this.price,
    this.discountPrice,
    this.serviceImage,
    this.timeDuration,
    this.description,
    this.serviceIncludes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.rating,
    this.review,
  });

  int id;
  int categoryId;
  String categoryName;
  String serviceName;
  int price;
  int discountPrice;
  String serviceImage;
  String timeDuration;
  String description;
  dynamic serviceIncludes;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  String rating;
  List<Review> review;

  factory ServiceDetails.fromJson(Map<String, dynamic> json) => ServiceDetails(
        id: json["id"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        serviceName: json["service_name"],
        price: json["price"],
        discountPrice: json["discount_price"],
        serviceImage: json["service_image"],
        timeDuration: json["time_duration"],
        description: json["description"],
        serviceIncludes: json["service_includes"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rating: json["rating"],
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "category_name": categoryName,
        "service_name": serviceName,
        "price": price,
        "discount_price": discountPrice,
        "service_image": serviceImage,
        "time_duration": timeDuration,
        "description": description,
        "service_includes": serviceIncludes,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rating": rating,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
      };
}

class Review {
  Review({
    this.id,
    this.userId,
    this.providerId,
    this.serviceId,
    this.starCount,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.userprofile,
  });

  int id;
  int userId;
  int providerId;
  int serviceId;
  String starCount;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  String userName;
  String userprofile;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["user_id"],
        providerId: json["provider_id"],
        serviceId: json["service_id"],
        starCount: json["star_count"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        userprofile: json["userprofile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "provider_id": providerId,
        "service_id": serviceId,
        "star_count": starCount,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_name": userName,
        "userprofile": userprofile,
      };
}
