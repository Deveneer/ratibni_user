import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ratibni_user/app/modules/add_and_edit_address/bindings/add_and_edit_address_binding.dart';
import 'package:ratibni_user/app/modules/add_and_edit_address/views/add_and_edit_address_view.dart';
import 'package:ratibni_user/app/modules/address/bindings/address_binding.dart';
import 'package:ratibni_user/app/modules/address/views/address_view.dart';
import 'package:ratibni_user/app/modules/book_service/bindings/book_service_binding.dart';
import 'package:ratibni_user/app/modules/book_service/views/book_service_view.dart';
import 'package:ratibni_user/app/modules/book_service_details/bindings/book_service_details_binding.dart';
import 'package:ratibni_user/app/modules/book_service_details/views/book_service_details_view.dart';
import 'package:ratibni_user/app/modules/booking_cancelled/bindings/booking_cancelled_binding.dart';
import 'package:ratibni_user/app/modules/booking_cancelled/views/booking_cancelled_view.dart';
import 'package:ratibni_user/app/modules/booking_details/bindings/booking_details_binding.dart';
import 'package:ratibni_user/app/modules/booking_details/views/booking_details_view.dart';
import 'package:ratibni_user/app/modules/booking_summary/bindings/booking_summary_binding.dart';
import 'package:ratibni_user/app/modules/booking_summary/views/booking_summary_view.dart';
import 'package:ratibni_user/app/modules/bookings/bindings/bookings_binding.dart';
import 'package:ratibni_user/app/modules/bookings/views/bookings_view.dart';
import 'package:ratibni_user/app/modules/change_and_reset_password/bindings/change_and_reset_password_binding.dart';
import 'package:ratibni_user/app/modules/change_and_reset_password/views/change_and_reset_password_view.dart';
import 'package:ratibni_user/app/modules/confirm_booking/bindings/confirm_booking_binding.dart';
import 'package:ratibni_user/app/modules/confirm_booking/views/confirm_booking_view.dart';
import 'package:ratibni_user/app/modules/contact_us/bindings/contact_us_binding.dart';
import 'package:ratibni_user/app/modules/contact_us/views/contact_us_view.dart';
import 'package:ratibni_user/app/modules/contents/bindings/contents_binding.dart';
import 'package:ratibni_user/app/modules/contents/views/contents_view.dart';
import 'package:ratibni_user/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:ratibni_user/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ratibni_user/app/modules/edit_profile/bindings/edit_profile_binding.dart';
import 'package:ratibni_user/app/modules/edit_profile/views/edit_profile_view.dart';
import 'package:ratibni_user/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:ratibni_user/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:ratibni_user/app/modules/login_and_signup/bindings/login_and_signup_binding.dart';
import 'package:ratibni_user/app/modules/login_and_signup/views/login_and_signup_view.dart';
import 'package:ratibni_user/app/modules/my_account/bindings/my_account_binding.dart';
import 'package:ratibni_user/app/modules/my_account/views/my_account_view.dart';
import 'package:ratibni_user/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:ratibni_user/app/modules/notifications/views/notifications_view.dart';
import 'package:ratibni_user/app/modules/otp_verification/bindings/otp_verification_binding.dart';
import 'package:ratibni_user/app/modules/otp_verification/views/otp_verification_view.dart';
import 'package:ratibni_user/app/modules/rate_and_review/bindings/rate_and_review_binding.dart';
import 'package:ratibni_user/app/modules/rate_and_review/views/rate_and_review_view.dart';
import 'package:ratibni_user/app/modules/search/bindings/search_binding.dart';
import 'package:ratibni_user/app/modules/search/views/search_view.dart';
import 'package:ratibni_user/app/modules/splash/bindings/splash_binding.dart';
import 'package:ratibni_user/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => DashboardView(),
        binding: DashboardBinding(),
        curve: Curves.easeIn),
    GetPage(
        name: _Paths.LOGIN_AND_SIGNUP,
        page: () => LoginAndSignupView(),
        binding: LoginAndSignupBinding(),
        curve: Curves.easeIn),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: ForgotPasswordBinding(),
        curve: Curves.easeIn),
    GetPage(
        name: _Paths.OTP_VERIFICATION,
        page: () => OtpVerificationView(),
        binding: OtpVerificationBinding(),
        curve: Curves.easeIn),
    GetPage(
        name: _Paths.NOTIFICATIONS,
        page: () => NotificationsView(),
        binding: NotificationsBinding(),
        curve: Curves.easeIn),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_DETAILS,
      page: () => BookingDetailsView(),
      binding: BookingDetailsBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACCOUNT,
      page: () => MyAccountView(),
      binding: MyAccountBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_AND_RESET_PASSWORD,
      page: () => ChangeAndResetPasswordView(),
      binding: ChangeAndResetPasswordBinding(),
      curve: Curves.easeIn,
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_SERVICE,
      page: () => BookServiceView(),
      binding: BookServiceBinding(),
    ),
    GetPage(
      name: _Paths.BOOK_SERVICE_DETAILS,
      page: () => BookServiceDetailsView(),
      binding: BookServiceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CONTENTS,
      page: () => ContentsView(),
      binding: ContentsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_SUMMARY,
      page: () => BookingSummaryView(),
      binding: BookingSummaryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_AND_EDIT_ADDRESS,
      page: () => AddAndEditAddressView(),
      binding: AddAndEditAddressBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_BOOKING,
      page: () => ConfirmBookingView(),
      binding: ConfirmBookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_CANCELLED,
      page: () => BookingCancelledView(),
      binding: BookingCancelledBinding(),
    ),
    GetPage(
      name: _Paths.RATE_AND_REVIEW,
      page: () => RateAndReviewView(),
      binding: RateAndReviewBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
