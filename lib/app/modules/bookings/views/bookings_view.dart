import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/modules/bookings/views/local_widgets/booking_card.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/floating_menu_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        floatingActionButton: Obx(
          () => FloatingMenuButton(
            isOpen: controller.isFloatingMenuButtonOpen.value,
            isVisible: controller.isFloatingMenuButtonVisible.value,
            onToggle: (bool isOpen) {
              controller.isFloatingMenuButtonOpen.value = isOpen;
            },
            currentNavigation: FloatingMenuButtonNavigation.BOOKMARK,
            isSamePageNavigation: false,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VerticalGap(
                        gap: 40,
                      ),
                      Text(
                        AppStrings.myBookings,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 26,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      VerticalGap(
                        gap: 30,
                      ),
                    ],
                  ),
                ),
                _buttonWidget(context),
                Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        controller.isFloatingMenuButtonVisible.value = true;
                      } else if (notification is ScrollStartNotification) {
                        controller.isFloatingMenuButtonOpen.value = false;
                        controller.isFloatingMenuButtonVisible.value = false;
                      }
                      return true;
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: BookingCard(),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => AppBackButton(
                shouldShow: controller.isFloatingMenuButtonVisible.value,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return Hero(
      tag: "seg_ctrl",
      child: Material(
        color: Colors.transparent,
        child: Obx(
          () => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.15),
            child: MaterialSegmentedControl(
              children: const <int, Widget>{
                0: Text(AppStrings.ongoing),
                1: Text(AppStrings.past),
              },
              horizontalPadding: EdgeInsets.zero,
              borderColor: AppColors.blueButton,
              selectedColor: AppColors.blueButton,
              selectionIndex: controller.currentSelectedIndex.value,
              borderRadius: 15,
              onSegmentChosen: (selectedIndex) {
                controller.currentSelectedIndex.value = selectedIndex;
              },
              unselectedColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
