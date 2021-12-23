import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class ChangeAndResetPasswordController extends GetxController {
  final oldPasswordTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final bool isFromChangePassword = Get.arguments['isFromChangePassword'];
  final phoneNumber = Get.arguments['phoneNumber'];
  final animationDuration = Duration(milliseconds: 600);
  final passwordsFormKey = GlobalKey<FormState>();

  ApiHelper apiHelper = Get.find<ApiHelper>();
  RxDouble positionOfDoneButtonRight = (-200.0).obs;
  RxDouble positionOfDoneButtonBottom = (60.0).obs;
  RxDouble positionOfHeaderText = (-150.0).obs;
  RxDouble positionOfForm = (Get.height).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    animateWidgets(reverse: true);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onDonePressed() {
    if (passwordsFormKey.currentState.validate()) {
      if (passwordTextEditingController.text ==
          confirmPasswordTextEditingController.text) {
        Map<String, String> requestMap = {
          if (!isFromChangePassword) 'mobile': phoneNumber,
          if (isFromChangePassword)
            'old_password': oldPasswordTextEditingController.text,
          'password': passwordTextEditingController.text,
          'confirm_password': confirmPasswordTextEditingController.text,
        };
        isFromChangePassword
            ? apiHelper.resetPassword(requestMap).then(
                (response) {
                  if (response.isOk) {
                    BotToast.showText(
                        text: AppStrings.passwordChangedSuccessfully);
                    animateWidgets();
                    Future.delayed(animationDuration).then(
                      (value) {
                        Get.back();
                      },
                    );
                  }
                },
              )
            : apiHelper.forgotAndResetPassword(requestMap).then(
                (response) {
                  if (response.isOk) {
                    BotToast.showText(
                        text: AppStrings.passwordResetSuccessfully);
                    animateWidgets();
                    Future.delayed(animationDuration).then(
                      (value) {
                        Get.offAndToNamed(Routes.LOGIN_AND_SIGNUP);
                      },
                    );
                  }
                },
              );
      } else {
        Get.snackbar(
          ApiErrors.passwordsNotMatching,
          ApiErrors.passwordsNotMatchingDetails,
        );
      }
    }
  }

  void animateWidgets({bool reverse = false}) {
    positionOfDoneButtonRight.value = reverse ? -56 : -200;
    positionOfForm.value = reverse ? 100 : Get.height;
    positionOfHeaderText.value = reverse ? 30 : -150;
  }
}
