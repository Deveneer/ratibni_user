import 'package:get/get.dart';
import 'package:ratibni_user/app/data/models/cancel_booking_response.dart';
import 'package:ratibni_user/app/data/models/my_bookings_response.dart';

class BookingCancelledController extends GetxController {
  final CancellationData cancelledBookingDetails =
      Get.arguments['cancelledBookingDetails'];
  final BookingDetails bookingDetailsOfSelectedIndex =
      Get.arguments['bookingDetailsOfSelectedIndex'];
  final animationDuration = Duration(milliseconds: 500);

  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 30;
  }

  @override
  void onClose() {}
}
