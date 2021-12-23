import 'package:get/get_connect/http/src/response/response.dart';

abstract class BaseApiHelper {
  // Login, Signup & Logout.
  Future<Response> signUp(Map<String, String> requestMap);
  Future<Response> login(Map<String, String> requestMap);
  Future<Response> verifyOtp(Map<String, String> requestMap, String apiToken);
  Future<Response> resendOtp(Map<String, String> requestMap);
  Future<Response> forgotPassword(Map<String, String> requestMap);
  Future<Response> forgotAndResetPassword(Map<String, String> requestMap);
  Future<Response> resetPassword(Map<String, String> requestMap);
  Future<Response> logout();

  // User Profile.
  Future<Response> updateProfile(Map<String, dynamic> requestMap);

  // CMS
  Future<Response> getTermsAndCondition();
  Future<Response> getAboutUs();
  Future<Response> getPrivacyPolicy();
  Future<Response> contactUs(Map<String, String> requestMap);
  Future<Response> getNotifications();

// Addresses.
  Future<Response> getAddress();
  Future<Response> addAddress(Map<String, String> requestMap);
  Future<Response> editAddress(Map<String, String> requestMap);
  Future<Response> deleteAddress(Map<String, String> requestMap);

  // Services.
  Future<Response> getServiceCategories();
  Future<Response> getServiceDetails(String categoryId);
  Future<Response> applyPromocode(Map<String, String> requestMap);
  Future<Response> addBooking(Map<String, dynamic> requestMap);
  Future<Response> getMyBookings();
  Future<Response> getCancelBookingReasons();
  Future<Response> cancelBooking(Map<String, String> requestMap);
  Future<Response> rescheduleBooking(Map<String, String> requestMap);
  Future<Response> rateAndReview(Map<String, String> requestMap);
  Future<Response> search(String query);
}
