import 'package:ratibni_user/app/core/constants/app_strings.dart';

class BookingStatusText {
  static final bookingStatusHeaderText = [
    AppStrings.serviceRequested,
    AppStrings.bookingConfirm,
    AppStrings.onTheWay,
    AppStrings.serviceStarted,
    AppStrings.serviceCompleted,
    AppStrings.serviceCancelled,
  ];
  // No Button is available for ==> Booking Confirm, Service Started, Service Canceled.
  // While Service Requested  ==> Show Cancel Booking & Reschedule Button.
  // While On The Way ==> Show Track Location Button.
  // While Service Completed ==> Show Rating & Review Button.
}
