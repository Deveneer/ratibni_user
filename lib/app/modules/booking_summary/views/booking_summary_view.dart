import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/booking_summary_controller.dart';

class BookingSummaryView extends GetView<BookingSummaryController> {
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
                          AppStrings.bookingSummary.toUpperCase(),
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
                                VerticalGap(
                                  gap: 50,
                                ),
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
                        AppStrings.placeABooking.toUpperCase(),
                        textAlignment: Alignment.centerLeft,
                        padding: 25,
                        buttonType: ButtonType.LEFT,
                        size: 165,
                        onTap: controller.goSelectAddress,
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
              controller.serviceDetails.serviceName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
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
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: controller.serviceDetails.discountPrice.toString(),
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
                    text: controller.serviceDetails.price.toString(),
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
              AppStrings.applyPromocode,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            VerticalGap(
              gap: 12,
            ),
            applyPromoCodeContainer(),
            VerticalGap(
              gap: 50,
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
              '${controller.serviceAmount}',
            ),
            Obx(
              () => rowText(
                AppStrings.promocode,
                '-${controller.promocodeAmount.value}',
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
                AppStrings.finalAmount,
                '${controller.finalAmount.value}',
                color: AppColors.blueButton,
                isBigFont: true,
              ),
            ),
            VerticalGap(gap: 170),
          ],
        ),
      ],
    );
  }

  Widget applyPromoCodeContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.blueButton),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Get.width * .55,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                cursorColor: Colors.black26,
                controller: controller.promoCodeTextController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          Expanded(
            child: applyButton(),
          ),
        ],
      ),
    );
  }

  InkWell applyButton() {
    return InkWell(
      onTap: controller.applyPromoCode,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(18),
          ),
          color: AppColors.blueButton,
          border: Border.all(color: AppColors.blueButton),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            AppStrings.apply,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ),
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
