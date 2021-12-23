import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/confirm_booking_controller.dart';

class ConfirmBookingView extends GetView<ConfirmBookingController> {
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
                          controller.bookingDetailsOfSelect.discountPrice == 0
                              ? AppStrings.requestAQuote.toUpperCase()
                              : AppStrings.confirmBooking.toUpperCase(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 25,
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
                              controller.bookServiceActionButtonLeftPosition
                                  .value = -40;
                            } else if (notification
                                is ScrollStartNotification) {
                              controller.isBackButtonVisible.value = false;
                              controller.bookServiceActionButtonLeftPosition
                                  .value = -(Get.width);
                            }
                            return true;
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 35),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                nonScrollingDetailsCard(),
                                Expanded(
                                  child: scrollingDetailsCard(context),
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
                  Obx(
                    () => AnimatedPositioned(
                      duration: controller.animationDuration,
                      right:
                          controller.bookServiceActionButtonLeftPosition.value,
                      bottom: 15,
                      child: CircularButton(
                        AppStrings.confirm.toUpperCase(),
                        textAlignment: Alignment.centerLeft,
                        padding: 25,
                        buttonType: ButtonType.LEFT,
                        size: 165,
                        onTap: controller.confirmBooking,
                      ),
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

  Widget nonScrollingDetailsCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.bookingDetailsOfSelect.serviceName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            if (controller.bookingDetailsOfSelect.discountPrice == 0)
              VerticalGap(gap: 5),
            if (controller.bookingDetailsOfSelect.discountPrice != 0)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppStrings.price}: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: controller.bookingDetailsOfSelect.discountPrice
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
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
                      text: controller.bookingDetailsOfSelect.price.toString(),
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
            if (controller.bookingDetailsOfSelect.discountPrice != 0)
              VerticalGap(
                gap: 20,
              ),
          ],
        ),
      ],
    );
  }

  Widget scrollingDetailsCard(context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.bookingDetailsOfSelect.description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15.5,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            Text(
              '${AppStrings.serviceScheduledFor} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            VerticalGap(
              gap: 5,
            ),
            Obx(
              () => Text(
                '${DateFormat.yMMMMd('en_US').format(DateTime.parse(controller.bookingDate.value))} - ${DateFormat.Hm().format(TimeProvider.getTime(controller.bookingTime.value))}',
                style: TextStyle(
                  color: AppColors.blueButton,
                  fontSize: 15,
                ),
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
              gap: 12,
            ),
            Text(
              '${AppStrings.bookingDetails} ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            VerticalGap(
              gap: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.navigation_outlined,
                  color: AppColors.lightOrange,
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.serviceLocation,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 17,
                        ),
                      ),
                      VerticalGap(gap: 5),
                      Container(
                        width: Get.width * .6,
                        child: Text(
                          '${controller.addressDetails.address} \n${controller.addressDetails.landmark}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                      Container(
                        width: Get.width * .6,
                        child: Text(
                          '${controller.addressDetails.city}, ${controller.addressDetails.state}, ${controller.addressDetails.country} - ${controller.addressDetails.zipcode}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                      Text(
                        '${AppStrings.phoneNumber}: ${USER_DETAILS.value.phoneNo}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalGap(
              gap: 35,
            ),
            if (controller.bookingDetailsOfSelect.discountPrice != 0)
              paymentSummaryColumn(),
            VerticalGap(gap: 170),
          ],
        ),
      ],
    );
  }

  Widget paymentSummaryColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.paymentSummary,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        VerticalGap(),
        rowText(
          '${AppStrings.serviceTotal}',
          '${controller.bookingSummaryController.serviceAmount}',
        ),
        Obx(
          () => rowText(
            '${AppStrings.promocode}',
            '-${controller.bookingSummaryController.promocodeAmount.value}',
            color: AppColors.blueButton,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            color: AppColors.textSecondary,
          ),
        ),
        Obx(
          () => rowText(
            '${AppStrings.finalAmount}',
            '${controller.bookingSummaryController.finalAmount.value}',
            color: AppColors.blueButton,
            isBigFont: true,
          ),
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
              fontSize: isBigFont ? 17.7 : 16,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: color != null ? color : Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: isBigFont ? 17.7 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
