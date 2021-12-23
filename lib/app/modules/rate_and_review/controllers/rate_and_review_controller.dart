import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class RateAndReviewController extends GetxController {
  final Duration animationDuration = Duration(milliseconds: 500);
  final serviceProviderRatingTextController = TextEditingController();
  final serviceRatingTextController = TextEditingController();
  final serviceId = Get.arguments['serviceId'];
  final providerId = Get.arguments['providerId'];
  final apiHelper = Get.find<ApiHelper>();

  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble bookServiceActionButtonLeftPosition = (-Get.width).obs;
  RxDouble serviceProviderRating = 5.0.obs;
  RxDouble serviceRating = 5.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 30;
    bookServiceActionButtonLeftPosition.value = -40;
  }

  @override
  void onClose() {}

  void submitRatingAndReview() {
    Map<String, String> serviecProviderRatingMap = {
      'provider_id': providerId.toString(),
      'star_count': serviceProviderRating.value.toString(),
      'message': serviceProviderRatingTextController.text
    };
    Map<String, String> serviecRatingMap = {
      'service_id': serviceId.toString(),
      'star_count': serviceRating.value.toString(),
      'message': serviceRatingTextController.text,
    };
    apiHelper.rateAndReview(serviecProviderRatingMap).then(
      (providerRatingResponse) {
        if (providerRatingResponse.isOk) {
          apiHelper.rateAndReview(serviecRatingMap).then(
            (serviceRatingResponse) {
              if (serviceRatingResponse.isOk) {
                BotToast.showText(text: AppStrings.ratingAndReviewSubmitted);
                Get.back();
              }
            },
          );
        }
      },
    );
  }
}
