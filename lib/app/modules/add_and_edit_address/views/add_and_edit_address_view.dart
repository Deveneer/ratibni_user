import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/add_and_edit_address_controller.dart';

class AddAndEditAddressView extends GetView<AddAndEditAddressController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalGap(
                  gap: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(35, 20, 35, 25),
                  child: Text(
                    controller.addressDetails == null
                        ? AppStrings.addAddress.toUpperCase()
                        : AppStrings.editAddress.toUpperCase(),
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                VerticalGap(
                  gap: 20,
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        controller.isFloatingBackButtonsVisible.value = true;
                        controller.positionOfSaveAndUpdateButtonRight.value =
                            -35;
                      } else if (notification is ScrollStartNotification) {
                        controller.isFloatingBackButtonsVisible.value = false;
                        controller.positionOfSaveAndUpdateButtonRight.value =
                            -Get.width;
                      }
                      return true;
                    },
                    child: addOrEditAddressCard(),
                  ),
                ),
              ],
            ),
            Obx(
              () => AppBackButton(
                shouldShow: controller.isFloatingBackButtonsVisible.value,
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                right: controller.positionOfSaveAndUpdateButtonRight.value,
                bottom: 10,
                child: CircularButton(
                  controller.addressDetails == null
                      ? AppStrings.save.toUpperCase()
                      : AppStrings.update.toUpperCase(),
                  size: 150,
                  buttonType: ButtonType.RIGHT,
                  textAlignment: controller.addressDetails == null
                      ? Alignment.center
                      : Alignment.centerLeft,
                  padding: 25,
                  onTap: controller.addressDetails == null
                      ? controller.addAddress
                      : controller.updateAddress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addOrEditAddressCard() {
    return Form(
      key: controller.addressFormKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        children: [
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.addressTextController,
            keyboardType: TextInputType.text,
            labelText: AppStrings.address,
            validatorErrorText: ErrorText.addressErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.landmarkTextController,
            keyboardType: TextInputType.text,
            labelText: AppStrings.landMark,
            validatorErrorText: ErrorText.landmarkErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.cityTextController,
            keyboardType: TextInputType.text,
            labelText: AppStrings.city,
            validatorErrorText: ErrorText.cityErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.stateTextController,
            keyboardType: TextInputType.text,
            labelText: AppStrings.state,
            validatorErrorText: ErrorText.stateErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.countryTextController,
            keyboardType: TextInputType.text,
            labelText: AppStrings.country,
            validatorErrorText: ErrorText.countryErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            borderCursorAndTextColor: AppColors.blueButton,
            controller: controller.postalCodeTextController,
            keyboardType: TextInputType.number,
            labelText: AppStrings.postalCode,
            validatorErrorText: ErrorText.postalCodeErrorText,
          ),
          VerticalGap(gap: 400),
        ],
      ),
    );
  }
}
