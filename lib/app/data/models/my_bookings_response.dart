// To parse this JSON data, do
//
//     final myBookingsResponse = myBookingsResponseFromJson(jsonString);

import 'dart:convert';

MyBookingsResponse myBookingsResponseFromJson(String str) =>
    MyBookingsResponse.fromJson(json.decode(str));

String myBookingsResponseToJson(MyBookingsResponse data) =>
    json.encode(data.toJson());

class MyBookingsResponse {
  MyBookingsResponse({
    this.errorCode,
    this.msg,
    this.data,
  });

  int errorCode;
  String msg;
  List<BookingDetails> data;

  factory MyBookingsResponse.fromJson(Map<String, dynamic> json) =>
      MyBookingsResponse(
        errorCode: json["error_code"],
        msg: json["msg"],
        data: List<BookingDetails>.from(json["data"].map((x) => BookingDetails.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BookingDetails {
  BookingDetails({
    this.id,
    this.bookingId,
    this.userId,
    this.addressId,
    this.categoryId,
    this.servicesId,
    this.promocodeId,
    this.amount,
    this.bookingDate,
    this.bookingTime,
    this.providerId,
    this.companyId,
    this.bookingOtp,
    this.userRequirement,
    this.requirementImage,
    this.status,
    this.duty,
    this.createdAt,
    this.updatedAt,
    this.getAddress,
    this.getPromo,
    this.getCategory,
    this.getService,
  });

  int id;
  String bookingId;
  int userId;
  int addressId;
  int categoryId;
  int servicesId;
  int promocodeId;
  int amount;
  String bookingDate;
  String bookingTime;
  dynamic providerId;
  dynamic companyId;
  int bookingOtp;
  String userRequirement;
  List<String> requirementImage;
  String status;
  String duty;
  DateTime createdAt;
  DateTime updatedAt;
  GetAddress getAddress;
  GetPromo getPromo;
  GetCategory getCategory;
  GetService getService;

  factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        addressId: json["address_id"],
        categoryId: json["category_id"],
        servicesId: json["services_id"],
        promocodeId: json["promocode_id"],
        amount: json["amount"],
        bookingDate: json["booking_date"],
        bookingTime: json["booking_time"],
        providerId: json["provider_id"],
        companyId: json["company_id"],
        bookingOtp: json["booking_otp"],
        userRequirement: json["user_requirement"],
        requirementImage:
            List<String>.from(json["requirement_image"].map((x) => x)),
        status: json["status"],
        duty: json["duty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        getAddress: json["get_address"] == null
            ? null
            : GetAddress.fromJson(json["get_address"]),
        getPromo: json["get_promo"] == null
            ? null
            : GetPromo.fromJson(json["get_promo"]),
        getCategory: GetCategory.fromJson(json["get_category"]),
        getService: GetService.fromJson(json["get_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "user_id": userId,
        "address_id": addressId,
        "category_id": categoryId,
        "services_id": servicesId,
        "promocode_id": promocodeId,
        "amount": amount,
        "booking_date": bookingDate,
        "booking_time": bookingTime,
        "provider_id": providerId,
        "company_id": companyId,
        "booking_otp": bookingOtp,
        "user_requirement": userRequirement,
        "requirement_image": List<dynamic>.from(requirementImage.map((x) => x)),
        "status": status,
        "duty": duty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "get_address": getAddress == null ? null : getAddress.toJson(),
        "get_promo": getPromo == null ? null : getPromo.toJson(),
        "get_category": getCategory.toJson(),
        "get_service": getService.toJson(),
      };
}

class GetAddress {
  GetAddress({
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
    this.userName,
    this.email,
    this.phoneNo,
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
  String userName;
  String email;
  String phoneNo;

  factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
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
        userName: json["user_name"],
        email: json["email"],
        phoneNo: json["phone_no"],
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
        "user_name": userName,
        "email": email,
        "phone_no": phoneNo,
      };
}

class GetCategory {
  GetCategory({
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
  dynamic iconImage;
  int status;
  dynamic createdAt;
  dynamic updatedAt;

  factory GetCategory.fromJson(Map<String, dynamic> json) => GetCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        iconImage: json["icon_image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon_image": iconImage,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class GetPromo {
  GetPromo({
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

  factory GetPromo.fromJson(Map<String, dynamic> json) => GetPromo(
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

class GetService {
  GetService({
    this.id,
    this.categoryId,
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
  });

  int id;
  int categoryId;
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

  factory GetService.fromJson(Map<String, dynamic> json) => GetService(
        id: json["id"],
        categoryId: json["category_id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
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
      };
}
