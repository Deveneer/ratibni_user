import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/modules/otp_verification/controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  @override
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
                  width: Get.width,
                  height: Get.height,
                  child: Stack(
                    children: [
                      Obx(
                        () => AnimatedPositioned(
                          child: Text(
                            AppStrings.otpVerification,
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.orange,
                            ),
                          ),
                          top: 50,
                          left: controller.headerTextPosition.value,
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
                              color: AppColors.blueButton),
                          child: Form(
                            key: controller.otpFormKey,
                            child: otpFormTextField(context),
                          ),
                        ),
                      ),
                      Obx(
                        () => AnimatedPositioned(
                          duration: controller.animationDuration,
                          right: controller.positionSubmitButtonRight.value,
                          bottom: controller.positionSubmitButtonBottom.value,
                          child: CircularButton(
                            controller.isFromForgetPassword
                                ? AppStrings.next
                                : AppStrings.submit,
                            onTap: controller
                                .verifyOtpAndGoToDashboardOrResetPassword,
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

  Widget otpFormTextField(context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 12),
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(
            AppStrings.pleaseEnterOtpMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          VerticalGap(
            gap: 40,
          ),
          SizedBox(
            width: 230,
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              length: 4,
              obscureText: true,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (otp) => otp.length < 4 ? ErrorText.otpErrorText : null,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                activeColor: Colors.white,
                inactiveColor: Colors.white70,
                activeFillColor: Colors.white,
                selectedColor: Colors.white,
                fieldWidth: 50,
              ),
              textStyle: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              backgroundColor: AppColors.blueButton,
              animationDuration: Duration(milliseconds: 300),
              keyboardType: TextInputType.number,
              controller: controller.otpTextEditingController,
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
                // if you return true then it will show the paste confirmation dialog.
                // Otherwise if false, then nothing will happen. but you can show
                // anything you want here, like your pop up saying wrong paste format or etc
              },
            ),
          ),
          VerticalGap(
            gap: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (controller.isResendOtpEnabled.value) {
                    controller.isResendOtpEnabled.value = false;
                    controller.startTimer();
                    controller.resendOtp();
                  }
                },
                child: Text(
                  AppStrings.resendOtp,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !controller.isResendOtpEnabled.value,
                  child: Text(
                    ": ${controller.timerText}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
