import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/models/notifications_response.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
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
                  gap: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Text(
                   AppStrings.notifications,
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                VerticalGap(
                  gap: 35,
                ),
                Expanded(
                  child: NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        controller.isButtonVisible.value = true;
                      } else if (notification is ScrollStartNotification) {
                        controller.isButtonVisible.value = false;
                      }
                      return true;
                    },
                    child: Obx(
                      () => Container(
                        child: controller.isUserGuest.value
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35.0),
                                child: Text(
                                  AppStrings.notificationsNotAvailableForGuest,
                                  style: Get.textTheme.headline6.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : controller.notificationList.length == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 35.0,
                                    ),
                                    child: Text(
                                      AppStrings.notificationsNotAvailable,
                                      style: Get.textTheme.headline6.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        controller.notificationList.length,
                                    itemBuilder: (context, index) {
                                      return notificationCard(
                                          controller.notificationList[index]);
                                    },
                                  ),
                      ),
                    ),
                  ),
                ),
                VerticalGap(
                  gap: 100,
                ),
              ],
            ),
            Obx(
              () => AppBackButton(
                shouldShow: controller.isButtonVisible.value,
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox notificationCard(NotificationList notification) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            child: InkWell(
              onTap: () {
                print('Notification has been pressed.');
              },
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  VerticalGap(gap: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.clickToView,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        "8 min ago",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.textSecondary,
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
