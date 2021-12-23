import 'package:ratibni_user/app/data/models/my_bookings_response.dart';

class BookingFilter {
  static List<BookingDetails> getCompetedAndCanceledBookings(
      List<BookingDetails> bookingsList) {
    List<BookingDetails> completedBookings = [];
    for (BookingDetails booking in bookingsList) {
      if (booking.status == "4" || booking.status == "5")
        completedBookings.add(booking);
    }
    return completedBookings;
  }

  static List<BookingDetails> getOngoingBookingsList(
      List<BookingDetails> bookingsList) {
    List<BookingDetails> ongoingBookingsList = [];
    for (BookingDetails booking in bookingsList) {
      if (booking.status == "0" ||
          booking.status == "1" ||
          booking.status == "2" ||
          booking.status == "3") ongoingBookingsList.add(booking);
    }
    return ongoingBookingsList;
  }
}
