import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/modules/forgot_password/controllers/forgot_password_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              VerticalGap(
                gap: 50,
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      Obx(
                        () => AnimatedPositioned(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(
                              AppStrings.forgotPassword.toUpperCase(),
                              style: TextStyle(
                                fontSize: 20,
                                color: AppColors.orange,
                              ),
                            ),
                          ),
                          top: 20,
                          left: controller.titleTextLeftPosition.value,
                          duration: controller.animationDuration,
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                            color: AppColors.blueButton,
                          ),
                          child: _formTextField(),
                        ),
                      ),
                      Obx(
                        () => AnimatedPositioned(
                          duration: controller.animationDuration,
                          right: controller.positionBackAndSubmitButton.value,
                          bottom: 60,
                          child: CircularButton(
                            AppStrings.submit,
                            onTap: controller.goToOtpVerification,
                          ),
                        ),
                      ),
                      Obx(
                        () => AnimatedPositioned(
                          duration: controller.animationDuration,
                          left: controller.positionBackAndSubmitButton.value,
                          bottom: 25,
                          child: CircularButton(
                            AppStrings.backToLogin,
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formTextField() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              AppStrings.enterYourPhoneNumberText,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            VerticalGap(
              gap: 40,
            ),
            Form(
              key: controller.phoneNumberFormKey,
              child: PhoneTextField(
                controller: controller.phoneNumberTextController,
                borderCursorAndTextColor: Colors.white,
              ),
            ),
            VerticalGap(
              gap: Get.height * .88,
            ),
          ],
        ),
      ),
    );
  }
}
