import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class LoginAndSignupController extends GetxController {
  final apiHelper = Get.find<ApiHelper>();
  final animationDuration = Duration(milliseconds: 500);
  final loginFormKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();
  final firstNameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  RxBool isCurrentViewLogin = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble positionLoginAndSignupButton = (-Get.width).obs;

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 0;
    positionLoginAndSignupButton.value = -30;
  }

  void changeCurrentViewToSignup() {
    isCurrentViewLogin.toggle();
  }

  void loginAndGoToDashboard() {
    if (loginFormKey.currentState.validate()) {
      Map<String, String> requestMap = {
        'email': emailTextController.text,
        'password': passwordTextController.text,
        'user_type': '0'
      };
      apiHelper.login(requestMap).then(
        (response) {
          if (response.isOk) {
            LoginAndSignUpResponse responseData =
                LoginAndSignUpResponse.fromJson(response.body);
            USER_TOKEN.value = responseData.data.accessToken;
            SessionManager.saveToken(USER_TOKEN.value);

            USER_DETAILS.value = responseData.data;
            SessionManager.saveUserDetails(USER_DETAILS.value);
            Get.offAllNamed(Routes.DASHBOARD);
          }
        },
      );
    }
  }

  void signupAndGoToOtpVerification() {
    if (signUpFormKey.currentState.validate()) {
      Map<String, String> requestMap = {
        'first_name': GetUtils.capitalizeFirst(firstNameTextController.text),
        'last_name': GetUtils.capitalizeFirst(lastNameTextController.text),
        'email': emailTextController.text,
        'phone_no': phoneNumberTextController.text,
        'country_code': AppStrings.countryCode,
        'password': passwordTextController.text,
        'confirm_password': passwordTextController.text
      };
      apiHelper.signUp(requestMap).then(
        (response) {
          if (response.isOk) {
            LoginAndSignUpResponse responseData =
                LoginAndSignUpResponse.fromJson(response.body);
            USER_TOKEN.value = responseData.data.accessToken;
            USER_DETAILS.value = responseData.data;

            Get.offAllNamed(
              Routes.OTP_VERIFICATION,
              arguments: {
                "isFromForgetPassword": false,
                'apiToken': responseData.data.apiToken,
                'phoneNumber': responseData.data.phoneNo,
                'otp': responseData.data.otp,
              },
            );
          } else if (response.status.isUnauthorized) {
            SignupErrorResponse responseData =
                SignupErrorResponse.fromJson(response.body);
            Get.snackbar(ApiErrors.unauthorised, responseData.message);
          }
        },
      );
    }
  }

  void goToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }
}
