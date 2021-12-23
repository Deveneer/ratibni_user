import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'dart:async';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class OtpVerificationController extends GetxController {
  String get timerText =>
      '${(initialTime.value ~/ 60).toString().padLeft(2, '0')}: ${(initialTime.value % 60).toString().padLeft(2, '0')}';

  ApiHelper apiHelper = Get.find<ApiHelper>();
  final otpTextEditingController = TextEditingController();
  final animationDuration = Duration(milliseconds: 500);
  final bool isFromForgetPassword = Get.arguments['isFromForgetPassword'];
  final apiToken = Get.arguments['apiToken'];
  final phoneNumber = Get.arguments['phoneNumber'];
  final otp = Get.arguments['otp'];
  final otpFormKey = GlobalKey<FormState>();

  RxDouble positionSubmitButtonRight = (-200.0).obs;
  RxDouble positionSubmitButtonBottom = (60.0).obs;
  RxDouble positionBackButtonLeft = (-200.0).obs;
  RxDouble positionBackButtonBottom = (20.0).obs;
  RxDouble headerTextPosition = (-150.0).obs;
  RxBool isResendOtpEnabled = false.obs;
  RxInt initialTime = 120.obs;
  Timer otpTimer;

  @override
  void onReady() {
    super.onReady();
    startTimer();
    animateWidgets(reverse: true);
  }

  @override
  void onClose() {
    super.onClose();
    otpTimer.cancel();
  }

  void startTimer() {
    initialTime.value = 120;
    const oneSec = const Duration(seconds: 1);
    otpTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (initialTime.value == 0) {
          timer.cancel();
          isResendOtpEnabled.toggle();
        } else {
          initialTime.value--;
        }
      },
    );
  }

  void verifyOtpAndGoToDashboardOrResetPassword() {
    if (otpFormKey.currentState.validate()) {
      Map<String, String> requestMap = {
        'otp': otpTextEditingController.text == AppStrings.otpBypassCode
            ? otp.toString() // OTP Bypass will be removed in future.
            : otpTextEditingController.text,
      };
      apiHelper.verifyOtp(requestMap, apiToken).then(
        (response) {
          if (response.isOk) {
            if (!isFromForgetPassword)
              SessionManager.saveToken(USER_TOKEN.value);

            if (!isFromForgetPassword)
              SessionManager.saveUserDetails(USER_DETAILS.value);

            animateWidgets();
            Future.delayed(animationDuration).then(
              (_) {
                isFromForgetPassword
                    ? Get.offAllNamed(
                        Routes.CHANGE_AND_RESET_PASSWORD,
                        arguments: {
                          'isFromChangePassword': false,
                          'phoneNumber': phoneNumber
                        },
                      )
                    : Get.offAllNamed(Routes.DASHBOARD);
              },
            );
          }
        },
      );
    }
  }

  void resendOtp() {
    Map<String, String> requestMap = {
      'phone_no': phoneNumber,
    };
    apiHelper.resendOtp(requestMap).then(
      (response) {
        if (response.isOk) {
          BotToast.showText(text: AppStrings.otpSendSuccessfully);
        }
      },
    );
  }

  void animateWidgets({bool reverse = false}) {
    positionSubmitButtonRight.value = reverse ? -30 : -200;
    positionBackButtonLeft.value = reverse ? -30 : -200;
    headerTextPosition.value = reverse ? 20 : -150;
  }
}
