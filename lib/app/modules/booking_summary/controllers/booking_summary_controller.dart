import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/discount.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/data/models/apply_promocode_response.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class BookingSummaryController extends GetxController {
  final ServiceDetails serviceDetails = Get.arguments['serviceDetails'];
  final Duration animationDuration = Duration(milliseconds: 500);
  final promoCodeTextController = TextEditingController();
  final apiHelper = Get.find<ApiHelper>();

  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble bookServiceActionButtonLeftPosition = (-Get.width).obs;

  RxInt promocodeAmount = 0.obs;
  int get serviceAmount => serviceDetails.discountPrice;
  RxInt get finalAmount => (serviceAmount - promocodeAmount.value).obs;
  RxString promocodeType = ''.obs;
  RxInt promocodeValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // To clear the last promocode saved as it is optional.
    BookingSessionManager.savePromoCode(
      AppStrings.notAvailable,
    );

    // To save the final amount if promocode is not used.
    BookingSessionManager.saveFinalPrice(
      finalAmount.value.toString(),
    );
  }

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 30;
    bookServiceActionButtonLeftPosition.value = -40;
  }

  @override
  void onClose() {}

  void applyPromoCode() {
    Map<String, String> requestMap = {
      'promocode': promoCodeTextController.text,
    };
    // To clear the previous promocode amount & promocode type.
    promocodeAmount.value = 0;
    promocodeType.value = '';

    apiHelper.applyPromocode(requestMap).then(
      (response) {
        if (response.isOk) {
          InvalidPromoCodeResponse invalidPromoCodeResponse =
              InvalidPromoCodeResponse.fromJson(response.body);

          BotToast.showText(text: invalidPromoCodeResponse.msg);
          if (invalidPromoCodeResponse.status) {
            ApplyPromoCodeResponse responseData =
                ApplyPromoCodeResponse.fromJson(response.body);
            BookingSessionManager.savePromoCode(
              responseData.data.id.toString(),
            );
            promocodeType.value = responseData.data.type;
            promocodeValue.value = responseData.data.value;
            promocodeAmount.value = Discount.getPromoDiscountAmount(
              promocodeType.value,
              promocodeValue.value,
              serviceAmount,
            );
          }
          BookingSessionManager.saveFinalPrice(
            finalAmount.value.toString(),
          );
        }
      },
    );
  }

  void goSelectAddress() {
    if (USER_TOKEN.value.length > 1)
      Get.toNamed(
        Routes.ADDRESS,
        arguments: {
          'isFromMyAccountScreen': false,
        },
      );
    else
      Get.defaultDialog(
        title: AppStrings.loginRequired,
        middleText: AppStrings.loginRequiredDetails,
        middleTextStyle: TextStyle(fontSize: 18),
        radius: 5,
        buttonColor: AppColors.lightOrange,
        confirmTextColor: Colors.white,
        textConfirm: AppStrings.login,
        onConfirm: () {
          BookingSessionManager.clearSession();
          SessionManager.clearSession();
          SessionManager.saveUserTypeAsNonGuest();
          USER_TOKEN.value = '';
          USER_DETAILS.value = UserDetails();
          Get.offAllNamed(Routes.LOGIN_AND_SIGNUP);
        },
      );
  }
}
