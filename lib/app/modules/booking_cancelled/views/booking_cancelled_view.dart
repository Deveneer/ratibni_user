import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/discount.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/booking_cancelled_controller.dart';

class BookingCancelledView extends GetView<BookingCancelledController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Get.height * .2,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Obx(
                    () => AnimatedPositioned(
                      duration: controller.animationDuration,
                      left: controller.titleLeftPosition.value,
                      child: LimitedBox(
                        maxWidth: Get.width * .8,
                        child: Text(
                          AppStrings.serviceCancelled
                              .replaceFirst(' ', '\n')
                              .toUpperCase(),
                          maxLines: 2,
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
                            }
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: scrollingDetailsCard(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Widget scrollingDetailsCard() {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.bookingId}: ${controller.cancelledBookingDetails.bookingId}",
              style: TextStyle(fontSize: 22),
            ),
            VerticalGap(
              gap: 4,
            ),
            Text(
              '${AppStrings.cancelledOn} ${DateFormat.yMMMMd('en_US').format(controller.cancelledBookingDetails.updatedAt)} - ${DateFormat.Hm().format(controller.cancelledBookingDetails.updatedAt)}',
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            VerticalGap(
              gap: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller
                          .bookingDetailsOfSelectedIndex.getService.serviceName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    VerticalGap(gap: 2),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${AppStrings.price}: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: controller.bookingDetailsOfSelectedIndex
                                .getService.discountPrice
                                .toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          TextSpan(
                            text: ' ${AppStrings.currency}   ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: controller
                                .bookingDetailsOfSelectedIndex.getService.price
                                .toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          TextSpan(
                            text: ' ${AppStrings.currency}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            VerticalGap(
              gap: 30,
            ),
            Text(
              controller.bookingDetailsOfSelectedIndex.getService.description,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: AppColors.textSecondary,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            Text(
              AppStrings.paymentSummary,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            VerticalGap(),
            rowText(
              AppStrings.serviceTotal,
              controller.bookingDetailsOfSelectedIndex.getService.discountPrice
                  .toString(),
            ),
            rowText(
              AppStrings.promocode,
              '-${Discount.getPromoDiscountAmount(
                controller.bookingDetailsOfSelectedIndex.getPromo?.type
                    .toString(),
                controller.bookingDetailsOfSelectedIndex.getPromo?.value ?? 0,
                controller
                    .bookingDetailsOfSelectedIndex.getService.discountPrice,
              )}'
                  .toString(),
              color: AppColors.blueButton,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: AppColors.textSecondary,
              ),
            ),
            rowText(
              AppStrings.finalAmount,
              controller.cancelledBookingDetails.amount.toString(),
              color: Colors.red,
              isBigFont: true,
            ),
            VerticalGap(gap: 170),
          ],
        ),
      ],
    );
  }

  Widget rowText(String text1, String text2,
      {bool isBigFont = false, Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              color: color != null ? color : Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: isBigFont ? 18.5 : 15.5,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: color != null ? color : Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: isBigFont ? 18.5 : 15.5,
            ),
          ),
        ],
      ),
    );
  }
}
