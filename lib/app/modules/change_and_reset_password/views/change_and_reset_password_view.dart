import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import '../controllers/change_and_reset_password_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class ChangeAndResetPasswordView
    extends GetView<ChangeAndResetPasswordController> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              VerticalGap(
                gap: 50,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Obx(
                        () => AnimatedPositioned(
                          child: Text(
                            controller.isFromChangePassword
                                ? AppStrings.chagnePassword
                                : AppStrings.resetPassword,
                            style: TextStyle(
                                fontSize: 22, color: AppColors.orange),
                          ),
                          top: 20,
                          left: controller.positionOfHeaderText.value,
                          duration: controller.animationDuration,
                        ),
                      ),
                      Obx(
                        () => AnimatedPositioned(
                          duration: controller.animationDuration,
                          top: controller.positionOfForm.value,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                              color: controller.isFromChangePassword
                                  ? Colors.white
                                  : AppColors.blueButton,
                            ),
                            child: _formTextField(),
                          ),
                        ),
                      ),
                      if (controller.isFromChangePassword)
                        AppBackButton(
                          shouldShow: true,
                        ),
                      Obx(
                        () => AnimatedPositioned(
                          duration: controller.animationDuration,
                          right: controller.positionOfDoneButtonRight.value,
                          bottom: controller.positionOfDoneButtonBottom.value,
                          child: CircularButton(
                            controller.isFromChangePassword
                                ? AppStrings.save
                                : AppStrings.done,
                            onTap: controller.onDonePressed,
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
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Form(
        key: controller.passwordsFormKey,
        child: Column(
          children: [
            VerticalGap(
              gap: 40,
            ),
            if (controller.isFromChangePassword)
              PasswordTextField(
                controller: controller.oldPasswordTextEditingController,
                labelText: AppStrings.oldPassword,
                borderCursorAndTextColor: AppColors.lightBlue,
              ),
            if (controller.isFromChangePassword)
              VerticalGap(
                gap: 15,
              ),
            PasswordTextField(
              controller: controller.passwordTextEditingController,
              labelText: controller.isFromChangePassword
                  ? AppStrings.newPassword
                  : AppStrings.enterPassword,
              borderCursorAndTextColor: controller.isFromChangePassword
                  ? AppColors.lightBlue
                  : Colors.white,
            ),
            VerticalGap(
              gap: 15,
            ),
            PasswordTextField(
              controller: controller.confirmPasswordTextEditingController,
              labelText: controller.isFromChangePassword
                  ? AppStrings.confirmNewPassword
                  : AppStrings.confirmPassword,
              borderCursorAndTextColor: controller.isFromChangePassword
                  ? AppColors.lightBlue
                  : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
