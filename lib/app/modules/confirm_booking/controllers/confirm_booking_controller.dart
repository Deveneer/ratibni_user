import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/models/address_response.dart';
import 'package:ratibni_user/app/modules/book_service_details/controllers/book_service_details_controller.dart';
import 'package:ratibni_user/app/modules/booking_summary/controllers/booking_summary_controller.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class ConfirmBookingController extends GetxController {
  BookingSummaryController bookingSummaryController;
  final bookingDetailsOfSelect =
      Get.find<BookServiceDetailsController>().serviceDetails;
  final Duration animationDuration = Duration(milliseconds: 500);
  final Address addressDetails = Get.arguments['addressDetails'];
  final apiHelper = Get.find<ApiHelper>();

  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble bookServiceActionButtonLeftPosition = (-Get.width).obs;
  RxString categoryId = ''.obs;
  RxString serviceId = ''.obs;
  RxString bookingDate = ''.obs;
  RxString bookingTime = ''.obs;
  RxString userRequirement = ''.obs;
  RxList<String> images = <String>[].obs;
  RxString promocodeId = ''.obs;
  RxString amount = ''.obs;
  RxString addressId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (bookingDetailsOfSelect.discountPrice != 0)
      bookingSummaryController = Get.find<BookingSummaryController>();

    if (bookingDetailsOfSelect.discountPrice == 0)
      BookingSessionManager.saveFinalPrice('0');

    BookingSessionManager.getBookingCategoryId().then(
      (id) {
        categoryId.value = id;
      },
    );
    BookingSessionManager.getBookingServiceId().then(
      (id) {
        serviceId.value = id;
      },
    );
    BookingSessionManager.getBookingDate().then(
      (date) {
        bookingDate.value = date;
      },
    );
    BookingSessionManager.getBookingTime().then(
      (time) {
        bookingTime.value = time;
      },
    );
    BookingSessionManager.getUserRequirement().then(
      (requirements) {
        userRequirement.value = requirements;
      },
    );
    BookingSessionManager.getImagesForBooking().then(
      (imagesForBooking) {
        images.value = imagesForBooking;
      },
    );
    BookingSessionManager.getPromoCode().then(
      (code) {
        promocodeId.value = code;
      },
    );
    BookingSessionManager.getFinalPrice().then(
      (finalAmount) {
        amount.value = finalAmount;
      },
    );
    BookingSessionManager.getAddressId().then(
      (id) {
        addressId.value = id;
      },
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

  void confirmBooking() {
    Map<String, dynamic> requestMap = {
      'category_id': categoryId.value,
      'service_id': serviceId.value,
      'booking_date': bookingDate.value,
      'booking_time': bookingTime.value,
      'user_requirement': userRequirement.value,
      'promocode_id': promocodeId.value,
      'amount': amount.value,
      'address_id': addressId.value,
    };

    for (int i = 0; i < images.length; i++) {
      final String image = images[i];
      requestMap['image[$i]'] = MultipartFile(
        File(image),
        filename: image.split("/").last,
      );
    }

    apiHelper.addBooking(requestMap).then(
      (response) {
        if (response.isOk) {
          BotToast.showText(
            text: amount.value != '0'
                ? AppStrings.serviceRequestedSuccessfully
                : AppStrings.serviceQuoteRequestedSuccessfully,
          );
          BookingSessionManager.clearSession();
          Get.until((route) => Get.currentRoute == Routes.DASHBOARD);
        }
      },
    );
  }
}
