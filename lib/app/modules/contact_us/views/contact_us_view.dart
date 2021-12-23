import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: Get.height,
                child: Stack(
                  children: [
                    Obx(
                      () => AnimatedPositioned(
                        top: 20,
                        left: controller.positionOfHeaderTextFromLeft.value,
                        duration: controller.animationDuration,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 15.0,
                            top: 25,
                          ),
                          child: Text(
                            AppStrings.contactUs.replaceFirst(' ', '\n'),
                            style: TextStyle(
                              fontSize: 27,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: controller.animationDuration,
                        top: controller.positionOfForm.value,
                        child: _formTextField(),
                      ),
                    ),
                    AppBackButton(
                      shouldShow: true,
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: controller.animationDuration,
                        right: controller.positionOfDoneButtonRight.value,
                        bottom: 15.0,
                        child: CircularButton(
                          AppStrings.submit,
                          size: 165,
                          textAlignment: Alignment.centerLeft,
                          padding: 30,
                          onTap: controller.onSubmitPressed,
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
    );
  }

  Widget _formTextField() {
    return Container(
      width: Get.width,
      height: Get.height,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
      child: Form(
        key: controller.contactUsKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VerticalGap(
                gap: 25,
              ),
              if (controller.isUserGuest.value)
                UniversalTextField(
                  controller: controller.nameTextEditingController,
                  keyboardType: TextInputType.name,
                  borderCursorAndTextColor: AppColors.lightBlue,
                  labelText: AppStrings.name,
                  validatorErrorText: ErrorText.firstNameErrorText,
                ),
              if (controller.isUserGuest.value)
                VerticalGap(
                  gap: 15,
                ),
              if (controller.isUserGuest.value)
                EmailTextField(
                  borderCursorAndTextColor: AppColors.lightBlue,
                  controller: controller.emailTextEditingController,
                ),
              if (controller.isUserGuest.value)
                VerticalGap(
                  gap: 15,
                ),
              if (controller.isUserGuest.value)
                PhoneTextField(
                  borderCursorAndTextColor: AppColors.lightBlue,
                  controller: controller.phoneNumberTextEditingController,
                ),
              if (controller.isUserGuest.value)
                VerticalGap(
                  gap: 15,
                ),
              Text(
                AppStrings.typeYourQuery,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlue,
                ),
              ),
              VerticalGap(
                gap: 10,
              ),
              RequestQuoteTextFeild(
                controller: controller.queryTextEditingController,
                borderAndCursorColor: AppColors.lightBlue,
              ),
              VerticalGap(
                gap: 550,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
