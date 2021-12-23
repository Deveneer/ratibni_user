enum BookingStatus {
  SERVICE_REQUESTED,
  SERVICE_ACCEPTED,
  ON_THE_WAY,
  SERVICE_STARTED,
  SERVICE_COMPLETED,
  BOOKING_CANCELLED
}

extension BookingStatusExtension on BookingStatus {
  String message() {
    switch (this) {
      case BookingStatus.SERVICE_REQUESTED:
        return "Service Requested";
        break;
      case BookingStatus.SERVICE_ACCEPTED:
        return "Service Accepted";
        break;
      case BookingStatus.ON_THE_WAY:
        return "On the way";
        break;
      case BookingStatus.SERVICE_STARTED:
        return "Service Started";
        break;
      case BookingStatus.SERVICE_COMPLETED:
        return "Service Completed";
        break;
      case BookingStatus.BOOKING_CANCELLED:
        return "Booking Cancelled";
        break;
      default:
        return "";
    }
  }
}
