import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/floating_button_positions.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/address_controller.dart';
import 'local_widgets/address_card.dart';

class AddressView extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                    controller.isFromMyAccountScreen
                        ? 
                        AppStrings.savedAddress.replaceFirst(' ', '\n') .toUpperCase()
                        :  AppStrings.selectAddress.toUpperCase(),
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
                        controller.isFloatingButtonsVisible.value = true;
                        controller.mainFloatingButtonRightPosition.value =
                            showCircularButtonLeftPosition;
                        controller.addAddressButtonLeftPostion.value = -30.0;
                      } else if (notification is ScrollStartNotification) {
                        controller.isFloatingButtonsVisible.value = false;
                        controller.mainFloatingButtonRightPosition.value =
                            hideCircularButtonLeftPosition;
                        controller.addAddressButtonLeftPostion.value =
                            -Get.width;
                      }
                      return true;
                    },
                    child: AddressCard(),
                  ),
                ),
              ],
            ),
            Obx(
              () => AppBackButton(
                shouldShow: controller.isFloatingButtonsVisible.value,
              ),
            ),
            if (!controller.isFromMyAccountScreen)
              Obx(
                () => AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left: controller.addAddressButtonLeftPostion.value,
                  bottom: 100,
                  child: CircularButton(
                    AppStrings.addAddress.toUpperCase(),
                    size: 150,
                    buttonType: ButtonType.RIGHT,
                    textAlignment: Alignment.center,
                    onTap: controller.goToAddAddress,
                  ),
                ),
              ),
            Obx(
              () => AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                left: controller.mainFloatingButtonRightPosition.value,
                bottom: 10,
                child: CircularButton(
                  controller.isFromMyAccountScreen
                      ? AppStrings.addAddress.toUpperCase()
                      : AppStrings.next.toUpperCase(),
                  size: 150,
                  buttonType: ButtonType.RIGHT,
                  textAlignment: controller.isFromMyAccountScreen
                      ? Alignment.centerLeft
                      : Alignment.center,
                  padding: 25,
                  onTap: controller.isFromMyAccountScreen
                      ? controller.goToAddAddress
                      : controller.saveAddressAndGoToConfirmBooking,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
