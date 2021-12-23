import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/data/models/forgot_password_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class ForgotPasswordController extends GetxController {
  final phoneNumberTextController = TextEditingController();
  final animationDuration = Duration(milliseconds: 600);
  final phoneNumberFormKey = GlobalKey<FormState>();
  final apiHelper = Get.find<ApiHelper>();

  RxDouble titleTextLeftPosition = (-Get.width).obs;
  RxDouble positionBackAndSubmitButton = (-Get.width).obs;

  @override
  void onReady() {
    super.onReady();
    titleTextLeftPosition.value = 0;
    positionBackAndSubmitButton.value = -40;
  }

  void goToOtpVerification() {
    if (phoneNumberFormKey.currentState.validate()) {
      Map<String, String> requestMap = {
        'phone_no': phoneNumberTextController.text
      };
      apiHelper.forgotPassword(requestMap).then(
        (response) {
          if (response.isOk) {
            ForgotPasswordResponse responseData =
                ForgotPasswordResponse.fromJson(response.body);
            Get.offAllNamed(
              Routes.OTP_VERIFICATION,
              arguments: {
                "isFromForgetPassword": true,
                'apiToken': responseData.data.apiToken,
                'phoneNumber': responseData.data.phoneNo,
                'otp': responseData.data.otp,
              },
            );
          }
        },
      );
    }
  }
}
