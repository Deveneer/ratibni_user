import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/core/utils/discount.dart';
import 'package:ratibni_user/app/data/models/cancel_booking_reasons_response.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/booking_details_controller.dart';

class BookingDetailsView extends GetView<BookingDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VerticalGap(
              gap: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 20, 35, 0),
              child: Text(
                controller.bookingStatusHeadline[int.parse(
                        controller.bookingDetailsOfSelectedIndex.status)]
                    ?.replaceFirst(" ", '\n')
                    ?.toUpperCase(),
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
                          controller.shouldShowBackNavigationButton.value =
                              true;
                          controller.bookingActionButtonRightPosition.value =
                              -30;
                          controller.rescheduleButtonLeftPosition.value = -20;
                        } else if (notification is ScrollStartNotification) {
                          controller.shouldShowBackNavigationButton.value =
                              false;
                          controller.bookingActionButtonRightPosition.value =
                              -Get.width;
                          controller.rescheduleButtonLeftPosition.value =
                              -Get.width;
                        }
                        return true;
                      },
                      child: bookingDetailsCard(),
                    ),
                  ),
                  Obx(
                    () => AppBackButton(
                      shouldShow:
                          controller.shouldShowBackNavigationButton.value,
                    ),
                  ),
                  if (controller.bookingDetailsOfSelectedIndex.status == "0")
                    circularBigLeftButton(
                      AppStrings.reschedule,
                      () {
                        openRescheduleDateAndTime();
                      },
                    ),
                  if (controller.bookingDetailsOfSelectedIndex.status == "0")
                    circularRightButton(
                      AppStrings.cancelRequest,
                      () {
                        controller.getCancelBookingReasons();
                        openCancellationReasonsList(
                          controller.cancelReasonsList,
                        );
                      },
                    ),
                  // if (controller.bookingDetailsOfSelectedIndex.status == "2")
                  //   circularRightButton(AppStrings.trackLocation, () {}),
                  if (controller.bookingDetailsOfSelectedIndex.status == "4")
                    circularRightButton(
                      AppStrings.rateAndReview,
                      () {
                        controller.rateAndReview();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Obx circularBigLeftButton(String buttonText, Function onTap) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        left: controller.rescheduleButtonLeftPosition.value,
        bottom: 110,
        child: CircularButton(
          buttonText,
          buttonType: ButtonType.LEFT,
          size: 170,
          onTap: onTap,
          textAlignment: Alignment.centerRight,
          padding: 25,
        ),
      ),
    );
  }

  Obx circularRightButton(String buttonText, Function onTap) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        right: controller.bookingActionButtonRightPosition.value,
        bottom: 10,
        child: CircularButton(
          buttonText,
          buttonType: ButtonType.LEFT,
          size: 150,
          onTap: onTap,
          textAlignment: Alignment.centerLeft,
          padding: 30,
        ),
      ),
    );
  }

  SingleChildScrollView bookingDetailsCard() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(35.0).copyWith(
          bottom: controller.bookingDetailsOfSelectedIndex.status == "0"
              ? 300
              : 200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.bookingId}: ${controller.bookingDetailsOfSelectedIndex.bookingId}",
              style: TextStyle(fontSize: 20),
            ),
            VerticalGap(
              gap: 4,
            ),
            Text(
              controller.bookingDetailsOfSelectedIndex.status == "5"
                  ? '${AppStrings.cancelledOn} ${DateFormat.yMMMMd('en_US').format(controller.bookingDetailsOfSelectedIndex.updatedAt)} - ${DateFormat.Hm().format(controller.bookingDetailsOfSelectedIndex.updatedAt)}'
                  : controller.bookingDetailsOfSelectedIndex.status == "4"
                      ? '${AppStrings.serviceCompletedOn} \n${DateFormat.yMMMMd('en_US').format(controller.bookingDetailsOfSelectedIndex.updatedAt)} - ${DateFormat.Hm().format(controller.bookingDetailsOfSelectedIndex.updatedAt)}'
                      : '${AppStrings.bookedFor} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(controller.bookingDetailsOfSelectedIndex.bookingDate))} - ${DateFormat.Hm().format(TimeProvider.getTime(controller.bookingDetailsOfSelectedIndex.bookingTime))}',
              style: TextStyle(
                fontSize: 16,
                color: controller.bookingDetailsOfSelectedIndex.status == "5"
                    ? Colors.red
                    : AppColors.blueButton,
              ),
            ),
            VerticalGap(
              gap: 4,
            ),
            Text(
              '${AppStrings.otp.toUpperCase()}: ${controller.bookingDetailsOfSelectedIndex.bookingOtp}',
              style: TextStyle(
                fontSize: 15,
                color: AppColors.lightOrange,
              ),
            ),
            if (controller.bookingDetailsOfSelectedIndex.status == "0")
              VerticalGap(
                gap: 30,
              ),
            if (controller.bookingDetailsOfSelectedIndex.status == "0")
              Text(
                AppStrings.messageForBookingSubmittedAndPayment,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
            VerticalGap(
              gap: 30,
            ),
            if (controller.bookingDetailsOfSelectedIndex.status != "0" &&
                controller.bookingDetailsOfSelectedIndex.status != "5")
              Text(
                AppStrings.assingedServiceProvider,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            VerticalGap(),
            if (controller.bookingDetailsOfSelectedIndex.status != "0" &&
                controller.bookingDetailsOfSelectedIndex.status != "5")
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Container(
                      color: AppColors.lightOrange,
                      width: 25,
                      height: 25,
                      child: Icon(
                        Icons.person,
                        size: 15,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  HorizontalGap(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best Cleaners',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      VerticalGap(
                        gap: 2,
                      ),
                      LimitedBox(
                        maxWidth: Get.width * 0.7,
                        child: Text(
                          '3+ Years Experience \n4.3 Ratings(71 Reviews)',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.lightOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (controller.bookingDetailsOfSelectedIndex.status != "0" &&
                controller.bookingDetailsOfSelectedIndex.status != "5")
              VerticalGap(
                gap: 40,
              ),
            Text(
              controller.bookingDetailsOfSelectedIndex.getService.serviceName,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${AppStrings.price}: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: controller.bookingDetailsOfSelectedIndex
                            .getService.discountPrice
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: ' ${AppStrings.currency}   ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: controller
                            .bookingDetailsOfSelectedIndex.getService.price
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      TextSpan(
                        text: ' ${AppStrings.currency}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalGap(
              gap: 25,
            ),
            Text(
              controller.bookingDetailsOfSelectedIndex.getService.description,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
            VerticalGap(
              gap: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            Text(
              AppStrings.bookingDetails,
              style: TextStyle(fontSize: 20),
            ),
            VerticalGap(
              gap: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.navigation_outlined,
                  color: AppColors.lightOrange,
                  size: 25,
                ),
                HorizontalGap(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.serviceLocation,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${controller.bookingDetailsOfSelectedIndex.getAddress?.address ?? AppStrings.notAvailable} ${controller.bookingDetailsOfSelectedIndex.getAddress?.landmark ?? ''}',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            VerticalGap(
              gap: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.lightOrange,
                  size: 25,
                ),
                HorizontalGap(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.timing,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '${DateFormat.yMMMMd('en_US').format(DateTime.parse(controller.bookingDetailsOfSelectedIndex.bookingDate))} - ${DateFormat.Hm().format(TimeProvider.getTime(controller.bookingDetailsOfSelectedIndex.bookingTime))}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (controller
                    .bookingDetailsOfSelectedIndex.requirementImage.length >
                0)
              VerticalGap(
                gap: 25,
              ),
            if (controller
                    .bookingDetailsOfSelectedIndex.requirementImage.length >
                0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.image,
                    color: AppColors.lightOrange,
                    size: 20,
                  ),
                  HorizontalGap(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.images,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        VerticalGap(gap: 15),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: controller.bookingDetailsOfSelectedIndex
                                .requirementImage.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index != 0) HorizontalGap(),
                                  imageBox(
                                    controller.bookingDetailsOfSelectedIndex
                                        .requirementImage[index],
                                  ),
                                  if (index !=
                                      controller.bookingDetailsOfSelectedIndex
                                              .requirementImage.length -
                                          1)
                                    HorizontalGap(),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            VerticalGap(
              gap: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            Text(
              AppStrings.paymentSummary,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalGap(gap: 15),
                rowText(
                  AppStrings.serviceTotal,
                  controller
                      .bookingDetailsOfSelectedIndex.getService.discountPrice
                      .toString(),
                ),
                rowText(
                  AppStrings.promocode,
                  '-${Discount.getPromoDiscountAmount(
                    controller.bookingDetailsOfSelectedIndex.getPromo?.type
                        .toString(),
                    controller.bookingDetailsOfSelectedIndex.getPromo?.value ??
                        0,
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
                  controller.bookingDetailsOfSelectedIndex.amount.toString(),
                  color: controller.bookingDetailsOfSelectedIndex.status == "5"
                      ? Colors.red
                      : AppColors.blueButton,
                  isBigFont: true,
                ),
              ],
            ),
          ],
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
              fontSize: isBigFont ? 17 : 15.5,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: color != null ? color : Colors.black87,
              fontWeight: FontWeight.w400,
              fontSize: isBigFont ? 17 : 15.5,
            ),
          ),
        ],
      ),
    );
  }

  ClipRRect imageBox(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blueButton,
          ),
        ),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Icon(
              Icons.error,
              size: 40,
            );
          },
        ),
      ),
    );
  }

  openCancellationReasonsList(List<CancelReason> listOfCancelReasons) {
    return Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: Get.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: Get.width,
                    height: Get.height * .44,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width * .7,
                              child: Text(
                                AppStrings.selectCancellationReason,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.orange,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.cancel_sharp,
                                size: 35,
                              ),
                              onPressed: Get.back,
                            ),
                          ],
                        ),
                        VerticalGap(
                          gap: 15,
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: listOfCancelReasons.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Row(
                                    children: [
                                      Obx(
                                        () => Radio(
                                          groupValue: controller
                                              .selectedButtonIndex.value,
                                          onChanged: (value) {
                                            controller.selectedButtonIndex
                                                .value = value;
                                          },
                                          value: index,
                                          activeColor: AppColors.orange,
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          width: Get.width * .6,
                                          child: Text(
                                            listOfCancelReasons[index].reason,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          controller.selectedButtonIndex.value =
                                              index;
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        VerticalGap(
                          gap: 45,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    right: -40,
                    child: CircularButton(
                      AppStrings.confirm,
                      buttonType: ButtonType.LEFT,
                      size: 165,
                      onTap: controller.cancelBooking,
                      textAlignment: Alignment.centerLeft,
                      padding: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  openRescheduleDateAndTime() {
    return Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: Get.height * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    width: Get.width,
                    height: Get.height * .44,
                    padding: EdgeInsets.fromLTRB(30, 40, 30, 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.selectDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                        VerticalGap(
                          gap: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            yearSelector(),
                            monthSelector(),
                            daySelector(),
                          ],
                        ),
                        VerticalGap(
                          gap: 25,
                        ),
                        Text(
                          AppStrings.selectTime,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                        VerticalGap(
                          gap: 12,
                        ),
                        timeSelector(),
                        VerticalGap(
                          gap: 25,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    right: -35,
                    child: CircularButton(
                      AppStrings.reschedule,
                      buttonType: ButtonType.LEFT,
                      size: 165,
                      onTap: controller.rescheduleBooking,
                      textAlignment: Alignment.centerLeft,
                      padding: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Scheduler.
  yearSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.blueButton,
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: controller.choosenYear.value.isNotEmpty
              ? controller.choosenYear.value
              : null,
          style: TextStyle(color: Colors.black),
          items: <String>[
            DateTime.now().year.toString(),
            (DateTime.now().year + 1).toString(),
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          hint: Text(
            AppStrings.year,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          onChanged: (String value) {
            controller.choosenYear.value = value;
          },
        ),
      ),
    );
  }

  Widget monthSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.blueButton,
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: controller.choosenMonth.value.isNotEmpty
              ? controller.choosenMonth.value
              : null,
          style: TextStyle(color: Colors.black),
          items: TimeProvider.monthList.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          hint: Text(
            AppStrings.month,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          onChanged: (String value) {
            controller.choosenMonth.value = value;
          },
        ),
      ),
    );
  }

  daySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.blueButton,
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: controller.choosenDay.value.isNotEmpty
              ? controller.choosenDay.value
              : null,
          style: TextStyle(color: Colors.black),
          items: <String>[...List.generate(31, (index) => '${index + 1}')]
              .map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          hint: Text(
            AppStrings.day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          onChanged: (String value) {
            controller.choosenDay.value = value;
          },
        ),
      ),
    );
  }

  timeSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: AppColors.blueButton,
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: controller.choosenTime.value.isNotEmpty
              ? controller.choosenTime.value
              : null,
          style: TextStyle(color: Colors.black),
          items: <String>[
            ...List.generate(
              47,
              (index) => index < 20
                  ? index % 2 == 0
                      ? '0${(index / 2).round()}:00'
                      : '0${((index - 1) / 2).round()}:30'
                  : index % 2 == 0
                      ? '${(index / 2).round()}:00'
                      : '${((index - 1) / 2).round()}:30',
            ),
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
          hint: Text(
            AppStrings.time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          onChanged: (String value) {
            controller.choosenTime.value = value;
          },
        ),
      ),
    );
  }
}
