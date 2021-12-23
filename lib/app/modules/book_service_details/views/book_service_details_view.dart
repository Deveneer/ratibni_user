import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/modules/book_service_details/controllers/book_service_details_controller.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/circular_rating_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'local_widgets/customer_review_card.dart';

class BookServiceDetailsView extends GetView<BookServiceDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Obx(
                    () => AnimatedPositioned(
                      duration: controller.animationDuration,
                      left: controller.titleLeftPosition.value,
                      child: Padding(
                        padding: controller.categoryName.contains(' ')
                            ? const EdgeInsets.only(top: 15.0)
                            : const EdgeInsets.only(top: 30.0),
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
                  ),
                ],
              ),
            ),
            Flexible(
              flex: controller.categoryName.contains(' ') ? 7 : 8,
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
                                  gap: 15,
                                ),
                                Obx(
                                  () => Expanded(
                                    child: scrollingDetailsCard(context),
                                  ),
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
                        controller.serviceDetails.discountPrice == 0
                            ? AppStrings.requestAQuote
                            : AppStrings.bookAService,
                        textAlignment: Alignment.centerLeft,
                        padding: controller.serviceDetails.discountPrice == 0
                            ? 30
                            : 40,
                        buttonType: ButtonType.LEFT,
                        size: 165,
                        onTap: controller.isScheduleOrAsapButtonEnabled.value
                            ? controller.goToBookingSummary
                            : controller.enableScheduleOrAsapButton,
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
            VerticalGap(
              gap: 2,
            ),
            if (controller.serviceDetails.discountPrice != 0)
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
        if (controller.serviceDetails.rating != null &&
            controller.serviceDetails.rating != '1.0')
          CircularRatingButton(
            rating: controller.serviceDetails.rating,
          )
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
            VerticalGap(
              gap: 10,
            ),
            Text(
              AppStrings.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
            VerticalGap(
              gap: 8,
            ),
            Text(
              controller.serviceDetails.description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15.5,
              ),
            ),
            VerticalGap(
              gap: 25,
            ),
            if (!controller.isScheduleOrAsapButtonEnabled.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.serviceIncludes,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  VerticalGap(
                    gap: 8,
                  ),
                  Text(
                    controller.serviceDetails.serviceIncludes ??
                        AppStrings.notAvailable,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15.5,
                    ),
                  ),
                  if (controller.serviceDetails.review.length > 0 ||
                      controller.serviceDetails.discountPrice == 0)
                    Divider(
                      color: Colors.black,
                      height: 50,
                      indent: 40,
                      endIndent: 50,
                    ),
                  if (controller.serviceDetails.discountPrice == 0)
                    Text(
                      AppStrings.yourRequirment,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  if (controller.serviceDetails.discountPrice == 0)
                    VerticalGap(
                      gap: 8,
                    ),
                  if (controller.serviceDetails.discountPrice == 0)
                    RequestQuoteTextFeild(
                      borderAndCursorColor: AppColors.lightBlue,
                      controller: controller.quoteTextEditingController,
                      totalLines: 4,
                    ),
                  if (controller.serviceDetails.discountPrice == 0)
                    VerticalGap(
                      gap: 25,
                    ),
                  if (controller.serviceDetails.discountPrice == 0 &&
                      controller.serviceDetails.review.length == 0)
                    VerticalGap(gap: Get.height * .5),
                  if (controller.serviceDetails.review.length > 0)
                    Text(
                      AppStrings.customerReviews,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  if (controller.serviceDetails.review.length > 0)
                    VerticalGap(
                      gap: 8,
                    ),
                  if (controller.serviceDetails.review.length > 0)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.serviceDetails.review.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomerReviewCard(
                            review: controller.serviceDetails.review[index],
                          ),
                        );
                      },
                    ),
                  if (controller.serviceDetails.discountPrice != 0)
                    VerticalGap(gap: 200),
                ],
              ),
            if (controller.isScheduleOrAsapButtonEnabled.value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.scheduleServieTiming,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  ),
                  VerticalGap(
                    gap: 12,
                  ),
                  Container(
                    child: scheduleOrAsapButton(context),
                    width: Get.width * .9,
                  ),
                  VerticalGap(
                    gap: 25,
                  ),
                  if (controller.isScheduleEnabled.value)
                    Column(
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
                        Text(
                          AppStrings.uploadImage,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                  VerticalGap(
                    gap: 12,
                  ),
                  uploadImageContainer(),
                  VerticalGap(gap: 170),
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget scheduleOrAsapButton(BuildContext context) {
    return Obx(
      () => MaterialSegmentedControl(
        children: const <int, Widget>{
          0: Text(
            AppStrings.asap,
            style: TextStyle(fontSize: 16),
          ),
          1: Text(
            AppStrings.schedule,
            style: TextStyle(fontSize: 16),
          ),
        },
        horizontalPadding: EdgeInsets.zero,
        borderColor: AppColors.blueButton,
        selectedColor: AppColors.blueButton,
        selectionIndex: controller.currentSelectedIndexOfButton.value,
        borderRadius: 32,
        onSegmentChosen: (selectedIndex) {
          controller.currentSelectedIndexOfButton.value = selectedIndex;
          if (selectedIndex == 1)
            controller.isScheduleEnabled.value = true;
          else
            controller.isScheduleEnabled.value = false;
        },
        unselectedColor: Colors.white,
      ),
    );
  }

  Widget uploadImageContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.lightBlue),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(
                    () => Text(
                      controller.multipleImagesName.value == ''
                          ? AppStrings.selectImages
                          : controller.multipleImagesName.value,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: controller.takeMultipleImages,
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
                  AppStrings.chooseFile,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ],
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
          items: <String>[
            ...List.generate(
                31, (index) => index < 9 ? '0${index + 1}' : '${index + 1}')
          ].map<DropdownMenuItem<String>>(
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
