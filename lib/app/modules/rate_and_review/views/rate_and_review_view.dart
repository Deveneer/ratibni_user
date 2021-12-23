import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import '../controllers/rate_and_review_controller.dart';

class RateAndReviewView extends GetView<RateAndReviewController> {
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
                          AppStrings.rateAndReview.toUpperCase(),
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
                            child: ratingAndReviewContainer(),
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
                        AppStrings.submit,
                        textAlignment: Alignment.centerLeft,
                        padding: 40,
                        buttonType: ButtonType.LEFT,
                        size: 160,
                        onTap: () {
                          controller.submitRatingAndReview();
                        },
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

  Widget ratingAndReviewContainer() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           AppStrings.rateServiceProvider,
            style: TextStyle(fontSize: 20),
          ),
          VerticalGap(
            gap: 20,
          ),
          ratingContainer(),
          VerticalGap(
            gap: 50,
          ),
          Text(
            AppStrings.rateService,
            style: TextStyle(fontSize: 20),
          ),
          VerticalGap(
            gap: 20,
          ),
          ratingContainer(isServiceProviderRating: false),
          VerticalGap(
            gap: 400,
          ),
        ],
      ),
    );
  }

  Container ratingContainer({bool isServiceProviderRating = true}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blueButton,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalGap(gap: 10),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (_, __) => Icon(
              Icons.star,
              color: AppColors.orange,
            ),
            onRatingUpdate: (newRating) {
              isServiceProviderRating
                  ? controller.serviceProviderRating.value = newRating
                  : controller.serviceRating.value = newRating;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5,
            ),
            child: Text(
              AppStrings.writeAReview,
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5,
            ),
            child: RequestQuoteTextFeild(
              controller: isServiceProviderRating
                  ? controller.serviceProviderRatingTextController
                  : controller.serviceRatingTextController,
              borderAndCursorColor: Colors.black,
              totalLines: 2,
            ),
          ),
          VerticalGap(gap: 10),
        ],
      ),
    );
  }
}
