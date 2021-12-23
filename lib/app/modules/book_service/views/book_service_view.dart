import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/book_service_detail_card.dart';
import '../controllers/book_service_controller.dart';

class BookServiceView extends GetView<BookServiceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 15),
              padding: EdgeInsets.only(bottom: 15),
              height: controller.categoryName.contains(' ')
                  ? Get.height * .17
                  : Get.height * .13,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Obx(
                    () => AnimatedPositioned(
                      duration: controller.animationDuration,
                      left: controller.titleLeftPosition.value,
                      child: LimitedBox(
                        maxWidth: Get.width * .88,
                        child: Text(
                          controller.categoryName
                              .toUpperCase()
                              .replaceFirst(" ", '\n'),
                          maxLines:
                              controller.categoryName.contains(' ') ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: NotificationListener(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              controller.isBackButtonVisible.value = true;
                            } else if (notification
                                is ScrollStartNotification) {
                              controller.isBackButtonVisible.value = false;
                              controller.isBackButtonVisible.value = false;
                            }
                            return true;
                          },
                          child: Obx(
                            () => controller.isServiceDetailsListEmpty.value
                                ? Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                      AppStrings.servicesNotAvailable,
                                      style: Get.textTheme.headline6.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : BookServiceDetailCard(
                                    serviceDetailsList:
                                        controller.serviceDetailsList,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(
                    () => AppBackButton(
                      shouldShow: controller.isBackButtonVisible.value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
