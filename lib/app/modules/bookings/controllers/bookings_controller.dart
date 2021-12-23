import 'package:get/get.dart';
import 'package:ratibni_user/app/core/utils/booking_status_text.dart';
import 'package:ratibni_user/app/core/utils/bookings_list_filter.dart';
import 'package:ratibni_user/app/data/models/my_bookings_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class BookingsController extends GetxController {
  final apiHelper = Get.find<ApiHelper>();

  final List<String> bookingStatusMessageList =
      BookingStatusText.bookingStatusHeaderText;

  RxBool isFloatingMenuButtonOpen = false.obs;
  RxBool isFloatingMenuButtonVisible = true.obs;
  RxInt currentSelectedIndex = 0.obs;
  RxList<BookingDetails> ongoingBookingsList = <BookingDetails>[].obs;
  RxList<BookingDetails> completedBookingsList = <BookingDetails>[].obs;
  RxBool isOngoingBookingsAvailable = true.obs;
  RxBool isCompletedBookingsAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    getMyBookings();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getMyBookings() {
    apiHelper.getMyBookings().then(
      (response) {
        if (response.isOk) {
          MyBookingsResponse responseData =
              MyBookingsResponse.fromJson(response.body);
          ongoingBookingsList.value =
              BookingFilter.getOngoingBookingsList(responseData.data);
          completedBookingsList.value =
              BookingFilter.getCompetedAndCanceledBookings(responseData.data);
          isOngoingBookingsAvailable.value =
              ongoingBookingsList.length != 0 ? true : false;
          isCompletedBookingsAvailable.value =
              completedBookingsList.length != 0 ? true : false;
        }
      },
    );
  }

  goToBookingDetailsScreen(BookingDetails bookingDetailsOfSelectedIndex) {
    Get.toNamed(
      Routes.BOOKING_DETAILS,
      arguments: {
        'bookingDetailsOfSelectedIndex': bookingDetailsOfSelectedIndex
      },
    );
  }

  void goToRateAndReview(servicesId, providerId) {
    Get.toNamed(
      Routes.RATE_AND_REVIEW,
      arguments: {
        'serviceId': servicesId,
        'providerId': providerId,
      },
    );
  }
}
