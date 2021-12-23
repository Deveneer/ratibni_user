import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/modules/login_and_signup/controllers/login_and_signup_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';

class LoginAndSignupView extends GetView<LoginAndSignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerTextContainer(),
            bodyContainer(),
          ],
        ),
      ),
    );
  }

  Expanded bodyContainer() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: AppColors.blueButton,
            ),
          ),
          SingleChildScrollView(
            child: Obx(
              () => controller.isCurrentViewLogin.value
                  ? Form(
                      key: controller.loginFormKey,
                      child: loginForm(),
                    )
                  : Form(
                      key: controller.signUpFormKey,
                      child: signUpForm(),
                    ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: controller.animationDuration,
              right: controller.positionLoginAndSignupButton.value,
              bottom: 60,
              child: CircularButton(
                controller.isCurrentViewLogin.value
                    ? AppStrings.login
                    : AppStrings.next,
                onTap: () {
                  controller.isCurrentViewLogin.value
                      ? controller.loginAndGoToDashboard()
                      : controller.signupAndGoToOtpVerification();
                },
                textAlignment: Alignment.center,
                size: 160,
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: controller.animationDuration,
              left: controller.positionLoginAndSignupButton.value,
              bottom: 25,
              child: CircularButton(
                controller.isCurrentViewLogin.value
                    ? AppStrings.signup
                    : AppStrings.backToLogin,
                onTap: controller.changeCurrentViewToSignup,
                textAlignment: Alignment.center,
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerTextContainer() {
    return Container(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Obx(
              () => AnimatedPositioned(
                duration: controller.animationDuration,
                left: controller.titleLeftPosition.value,
                child: Text(
                  controller.isCurrentViewLogin.value
                      ? AppStrings.login.toUpperCase()
                      : AppStrings.signup.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.orange,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signUpForm() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          UniversalTextField(
            controller: controller.firstNameTextController,
            keyboardType: TextInputType.name,
            borderCursorAndTextColor: Colors.white,
            labelText: AppStrings.firstName,
            validatorErrorText: ErrorText.firstNameErrorText,
          ),
          VerticalGap(
            gap: 18,
          ),
          UniversalTextField(
            controller: controller.lastNameTextController,
            keyboardType: TextInputType.name,
            borderCursorAndTextColor: Colors.white,
            labelText: AppStrings.lastName,
            validatorErrorText: ErrorText.lastNameErrorText,
          ),
          VerticalGap(
            gap: 18,
          ),
          EmailTextField(
            controller: controller.emailTextController,
            borderCursorAndTextColor: Colors.white,
          ),
          VerticalGap(
            gap: 18,
          ),
          PhoneTextField(
            controller: controller.phoneNumberTextController,
            borderCursorAndTextColor: Colors.white,
          ),
          VerticalGap(
            gap: 18,
          ),
          PasswordTextField(
            controller: controller.passwordTextController,
            borderCursorAndTextColor: Colors.white,
            labelText: AppStrings.password,
          ),
          VerticalGap(
            gap: Get.height * .7,
          ),
        ],
      ),
    );
  }

  Widget loginForm() {
    final whiteStyle = TextStyle(color: Colors.white, fontSize: 12);
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          EmailTextField(
            controller: controller.emailTextController,
            borderCursorAndTextColor: Colors.white,
          ),
          VerticalGap(
            gap: 18,
          ),
          PasswordTextField(
            controller: controller.passwordTextController,
            borderCursorAndTextColor: Colors.white,
            labelText: AppStrings.password,
          ),
          VerticalGap(
            gap: 4,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: controller.goToForgotPassword,
              child: Text(
                AppStrings.forgotPassword,
                style: whiteStyle,
              ),
            ),
          ),
          VerticalGap(
            gap: Get.height * .7,
          ),
        ],
      ),
    );
  }
}
