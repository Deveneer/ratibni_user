import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ratibni_user/app/core/constants/api_constants.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/utils/loader.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'base_api_helper.dart';
import 'package:get/get.dart';

class ApiHelper extends GetConnect with BaseApiHelper {
  @override
  void onInit() {
    httpClient.baseUrl = API_BASE_URL;
    httpClient.errorSafety = true;

    httpClient.addRequestModifier(
      (Request<dynamic> request) {
        Loader().showLoadingWidget();
        if (request.url.toString() != API_BASE_URL + API_VERIFY_OTP) {
          request.headers['Authorization'] = 'Bearer ' + USER_TOKEN.value;
          print('----Add addRequestModifier Called----');
        }
        return request;
      },
    );

    httpClient.addResponseModifier(
      (request, response) {
        debugPrint(
          '\n╔══════════════════════════ Response ══════════════════════════\n'
          '╟ REQUEST ║ ${request.method.toUpperCase()}\n'
          '╟ url: ${request.url}\n'
          '╟ Headers: ${request.headers}\n'
          '╟ Body: ${request.bodyBytes.map((event) => event.asMap().toString())}\n'
          '╟ Status Code: ${response.statusCode}\n'
          '╟ Data: ${response.bodyString?.toString() ?? ''}'
          '\n╚══════════════════════════ Response ══════════════════════════\n',
          wrapWidth: 1024,
        );
        if (response.hasError) {
          // Get.back() is used for removing Loader().showLoadingWidget();
          Get.back();
          if (response.status.connectionError)
            Get.snackbar(ApiErrors.noInternet, ApiErrors.noInternetDetails);
          else if (response.status.code == 400)
            Get.snackbar(ApiErrors.badRequest, ApiErrors.badRequestDetails);
          else if (response.status.isUnauthorized)
            Get.snackbar(ApiErrors.unauthorised, ApiErrors.unauthorisedDetails);
          else if (response.status.isForbidden)
            Get.snackbar(ApiErrors.forbidden, ApiErrors.forbiddenDetails);
          else if (response.status.code == 408)
            Get.snackbar(
                ApiErrors.serverTimeOut, ApiErrors.serverTimeOutDetails);
          else if (response.status.isNotFound)
            Get.snackbar(
                ApiErrors.serverNotFound, ApiErrors.serverNotFoundDetails);
          else if (response.status.isServerError)
            Get.snackbar(ApiErrors.serverError, ApiErrors.serverErrorDetails);
          else
            Get.snackbar(ApiErrors.unknownError, ApiErrors.unknownErrorDetails);
        } else if (response.isOk) {
          // Get.back() is used for removing Loader().showLoadingWidget();
          Get.back();
        }
      },
    );
  }

  // Login, Signup & Logout.
  @override
  Future<Response> signUp(Map<String, String> requestMap) async {
    final response = await post(
      API_SIGN_UP,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> verifyOtp(
      Map<String, String> requestMap, String apiToken) async {
    final response = await post(
      API_VERIFY_OTP,
      FormData(requestMap),
      headers: {'Authorization': apiToken},
    );
    return response;
  }

  @override
  Future<Response> resendOtp(Map<String, String> requestMap) async {
    final response = await post(
      API_RESEND_OTP,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> login(Map<String, String> requestMap) async {
    final response = await post(
      API_LOGIN,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> forgotPassword(Map<String, String> requestMap) async {
    final response = await post(
      API_FORGOT_PASSWORD,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> forgotAndResetPassword(
      Map<String, String> requestMap) async {
    final response = await post(
      API_FORGOT_AND_RESET_PASSWORD,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> resetPassword(Map<String, String> requestMap) async {
    final response = await post(
      API_RESET_PASSWORD,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> logout() async {
    final response = await post(
      API_LOGOUT,
      FormData({}),
    );
    return response;
  }

  // User Profile.
  @override
  Future<Response> updateProfile(Map<String, dynamic> requestMap) async {
    final response = await post(
      API_UPDATE_PROFILE,
      FormData(requestMap),
    );
    return response;
  }

  // CMS.
  @override
  Future<Response> getTermsAndCondition() async {
    final response = await get(API_TERMS_AND_CONDITIONS);
    return response;
  }

  @override
  Future<Response> getAboutUs() async {
    final response = await get(API_ABOUT_US);
    return response;
  }

  @override
  Future<Response> getPrivacyPolicy() async {
    final response = await get(API_PRIVACY_POLICY);
    return response;
  }

  @override
  Future<Response> contactUs(Map<String, String> requestMap) async {
    final response = await post(
      API_CONTACT_US,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> getNotifications() async {
    final response = await get(API_NOTIFICATIONS);
    return response;
  }

  // Addresses.
  @override
  Future<Response> getAddress() async {
    final response = await get(API_GET_ADDRESS);
    return response;
  }

  @override
  Future<Response> addAddress(Map<String, String> requestMap) async {
    final response = await post(
      API_ADD_ADDRESS,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> editAddress(Map<String, String> requestMap) async {
    final response = await post(
      API_EDIT_ADDRESS,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> deleteAddress(Map<String, String> requestMap) async {
    final response = await post(
      API_DELETE_ADDRESS,
      FormData(requestMap),
    );
    return response;
  }

  // Services.
  @override
  Future<Response> getServiceCategories() async {
    final response = await get(API_SERVICES_CATEGORIES);
    return response;
  }

  @override
  Future<Response> getServiceDetails(String categoryId) async {
    final response = await get(
      API_SERVICE_DETAILS + categoryId,
    );
    return response;
  }

  @override
  Future<Response> applyPromocode(Map<String, String> requestMap) async {
    final response = await post(
      API_APPLY_PROMOCODE,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> addBooking(Map<String, dynamic> requestMap) async {
    final response = await post(
      API_ADD_BOOKING,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> getMyBookings() async {
    final response = await get(API_MY_BOOKINGS);
    return response;
  }

  @override
  Future<Response> getCancelBookingReasons() async {
    final response = await get(API_CANCEL_REASONS);
    return response;
  }

  @override
  Future<Response> cancelBooking(Map<String, String> requestMap) async {
    final response = await post(
      API_CANCEL_BOOKING,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> rescheduleBooking(Map<String, String> requestMap) async {
    final response = await post(
      API_RESCHEDULE_BOOKING,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> rateAndReview(Map<String, String> requestMap) async {
    final response = await post(
      API_RATE_AND_REVIEW,
      FormData(requestMap),
    );
    return response;
  }

  @override
  Future<Response> search(query) async {
    final response = await get(
      API_SEARCH + query,
    );
    return response;
  }
}
