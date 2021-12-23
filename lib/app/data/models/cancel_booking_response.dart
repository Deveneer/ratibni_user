// To parse this JSON data, do
//
//     final cancelBookingResponse = cancelBookingResponseFromJson(jsonString);

import 'dart:convert';

CancelBookingResponse cancelBookingResponseFromJson(String str) =>
    CancelBookingResponse.fromJson(json.decode(str));

String cancelBookingResponseToJson(CancelBookingResponse data) =>
    json.encode(data.toJson());

class CancelBookingResponse {
  CancelBookingResponse({
    this.status,
    this.msg,
    this.data,
  });

  bool status;
  String msg;
  List<CancellationData> data;

  factory CancelBookingResponse.fromJson(Map<String, dynamic> json) =>
      CancelBookingResponse(
        status: json["status"],
        msg: json["msg"],
        data: List<CancellationData>.from(json["data"].map((x) => CancellationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CancellationData {
  CancellationData({
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
    this.cancelReasonId,
    this.cancelBy,
    this.userRequirement,
    this.requirementImage,
    this.status,
    this.duty,
    this.createdAt,
    this.updatedAt,
    this.reason,
  });

  int id;
  String bookingId;
  int userId;
  int addressId;
  int categoryId;
  int servicesId;
  int promocodeId;
  int amount;
  DateTime bookingDate;
  String bookingTime;
  dynamic providerId;
  dynamic companyId;
  int bookingOtp;
  int cancelReasonId;
  int cancelBy;
  String userRequirement;
  List<dynamic> requirementImage;
  String status;
  String duty;
  DateTime createdAt;
  DateTime updatedAt;
  String reason;

  factory CancellationData.fromJson(Map<String, dynamic> json) => CancellationData(
        id: json["id"],
        bookingId: json["booking_id"],
        userId: json["user_id"],
        addressId: json["address_id"],
        categoryId: json["category_id"],
        servicesId: json["services_id"],
        promocodeId: json["promocode_id"],
        amount: json["amount"],
        bookingDate: DateTime.parse(json["booking_date"]),
        bookingTime: json["booking_time"],
        providerId: json["provider_id"],
        companyId: json["company_id"],
        bookingOtp: json["booking_otp"],
        cancelReasonId: json["cancel_reason_id"],
        cancelBy: json["cancel_by"],
        userRequirement: json["user_requirement"],
        requirementImage:
            List<dynamic>.from(json["requirement_image"].map((x) => x)),
        status: json["status"],
        duty: json["duty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        reason: json["reason"],
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
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "booking_time": bookingTime,
        "provider_id": providerId,
        "company_id": companyId,
        "booking_otp": bookingOtp,
        "cancel_reason_id": cancelReasonId,
        "cancel_by": cancelBy,
        "user_requirement": userRequirement,
        "requirement_image": List<dynamic>.from(requirementImage.map((x) => x)),
        "status": status,
        "duty": duty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reason": reason,
      };
}
