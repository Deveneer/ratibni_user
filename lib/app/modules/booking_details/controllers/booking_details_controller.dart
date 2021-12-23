import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/booking_status_text.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/data/models/cancel_booking_reasons_response.dart';
import 'package:ratibni_user/app/data/models/cancel_booking_response.dart';
import 'package:ratibni_user/app/data/models/my_bookings_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class BookingDetailsController extends GetxController {
  final BookingDetails bookingDetailsOfSelectedIndex =
      Get.arguments['bookingDetailsOfSelectedIndex'];
  final apiHelper = Get.find<ApiHelper>();
  final List<String> bookingStatusHeadline =
      BookingStatusText.bookingStatusHeaderText;

  RxList<CancelReason> cancelReasonsList = <CancelReason>[].obs;
  RxBool shouldShowBackNavigationButton = true.obs;
  RxDouble bookingActionButtonRightPosition = (-Get.width).obs;
  RxDouble rescheduleButtonLeftPosition = (-Get.width).obs;
  RxInt selectedButtonIndex = (-1).obs;
  RxString choosenYear = ''.obs;
  RxString choosenMonth = ''.obs;
  RxString choosenDay = ''.obs;
  RxString choosenTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    bookingActionButtonRightPosition.value = -30;
    rescheduleButtonLeftPosition.value = -20;
  }

  void getCancelBookingReasons() {
    apiHelper.getCancelBookingReasons().then(
      (response) {
        if (response.isOk) {
          CancelBookingReasonsResponse responseData =
              CancelBookingReasonsResponse.fromJson(response.body);
          cancelReasonsList.value = responseData.data;
        }
      },
    );
  }

  void cancelBooking() {
    if (selectedButtonIndex.value != -1) {
      Map<String, String> requestMap = {
        'booking_id': bookingDetailsOfSelectedIndex.bookingId,
        'reason_id': cancelReasonsList[selectedButtonIndex.value].id.toString(),
      };
      apiHelper.cancelBooking(requestMap).then(
        (response) {
          if (response.isOk) {
            CancelBookingResponse responseData =
                CancelBookingResponse.fromJson(response.body);
            BotToast.showText(text: AppStrings.bookingCancelledSuccessfully);
            Get.offNamedUntil(
              Routes.BOOKING_CANCELLED,
              (route) => route.settings.name == Routes.DASHBOARD,
              arguments: {
                'cancelledBookingDetails': responseData.data[0],
                'bookingDetailsOfSelectedIndex': bookingDetailsOfSelectedIndex
              },
            );
          }
        },
      );
    } else
      Get.snackbar(
        AppStrings.reasonNotSelected,
        AppStrings.reasonNotSelectedDetails,
        backgroundColor: Colors.white,
      );
  }

  void rescheduleBooking() {
    if (choosenYear.value == '' ||
        choosenMonth.value == '' ||
        choosenDay.value == '' ||
        choosenTime.value == '') {
      Get.snackbar(
        AppStrings.dateAndTimeRequired,
        AppStrings.dateAndTimeRequiredDetails,
        backgroundColor: Colors.white,
      );
    } else {
      Map<String, String> requestMap = {
        'booking_id': bookingDetailsOfSelectedIndex.bookingId,
        'booking_date':
            '${choosenYear.value}-${TimeProvider.getMonth(choosenMonth.value)}-${choosenDay.value}',
        'booking_time': choosenTime.value,
      };
      apiHelper.rescheduleBooking(requestMap).then(
        (response) {
          if (response.isOk) {
            BotToast.showText(text: AppStrings.bookingRescheduledSuccessfully);
            Get.until((route) => Get.currentRoute == Routes.DASHBOARD);
          }
        },
      );
    }
  }

  void rateAndReview() {
    Get.toNamed(
      Routes.RATE_AND_REVIEW,
      arguments: {
        'serviceId': bookingDetailsOfSelectedIndex.servicesId,
        'providerId': bookingDetailsOfSelectedIndex.providerId,
      },
    );
  }
}
