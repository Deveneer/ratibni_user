import 'package:get_storage/get_storage.dart';

class BookingSessionManager {
  static final bookingDataSaver = GetStorage();
  static final String categoryIdKey = 'Category Id Key';
  static final String serviceIdKey = 'Service Id Key';
  static final String bookingDateKey = 'Booking Date Key';
  static final String bookingTimeKey = 'Booking Time Key';
  static final String userRequirementKey = 'User Requirement Key';
  static final String imagesKey = 'Images Key';
  static final String promoCodeKey = 'Promo Code Key';
  static final String finalPriceKey = 'Final Price Key';
  static final String addressIdKey = 'Address Id Key';

  static Future<void> saveBookingCategoryId(String categoryId) async {
    bookingDataSaver.write(categoryIdKey, categoryId);
    print("Category Id Saved ==> $categoryId.");
  }

  static Future<String> getBookingCategoryId() async {
    String categoryId = await bookingDataSaver.read(categoryIdKey);
    print("Category Id ==> $categoryId.");
    return categoryId;
  }

  static Future<void> saveBookingServiceId(String serviceId) async {
    bookingDataSaver.write(serviceIdKey, serviceId);
    print("Service Id Saved ==> $serviceId.");
  }

  static Future<String> getBookingServiceId() async {
    String serviceId = await bookingDataSaver.read(serviceIdKey);
    print("Service Id ==> $serviceId.");
    return serviceId;
  }

  static Future<void> saveBookingDate(String bookingDate) async {
    bookingDataSaver.write(bookingDateKey, bookingDate);
    print("Booking Date Saved ==> $bookingDate.");
  }

  static Future<String> getBookingDate() async {
    String bookingDate = await bookingDataSaver.read(bookingDateKey);
    print("Booking Date ==> $bookingDate.");
    return bookingDate;
  }

 static Future<void> saveBookingTime(String bookingTime) async {
    bookingDataSaver.write(bookingTimeKey, bookingTime);
    print("Booking Time Saved ==> $bookingTime.");
  }

  static Future<String> getBookingTime() async {
    String bookingTime = await bookingDataSaver.read(bookingTimeKey);
    print("Booking Time ==> $bookingTime.");
    return bookingTime;
  }


  static Future<void> saveUserRequirement(String userRequirement) async {
    bookingDataSaver.write(userRequirementKey, userRequirement);
    print("User Requirement Saved ==> $userRequirement.");
  }

  static Future<String> getUserRequirement() async {
    String userRequirement = await bookingDataSaver.read(userRequirementKey);
    print("User Requirement ==> $userRequirement.");
    return userRequirement;
  }

  static Future<void> saveImagesForBooking(List<String> imagesPathList) async {
    bookingDataSaver.write(imagesKey, imagesPathList);
    print("Images Path for Booking Saved ==> $imagesPathList.");
  }

  static Future<List<String>> getImagesForBooking() async {
    List<String> imagesPathList = await bookingDataSaver.read(imagesKey);
    print("Images Path for Booking ==> $imagesPathList.");
    return imagesPathList;
  }

  static Future<void> savePromoCode(String promoCode) async {
    bookingDataSaver.write(promoCodeKey, promoCode);
    print("Promo Code Id Saved ==> $promoCode.");
  }

  static Future<String> getPromoCode() async {
    var promoCode = await bookingDataSaver.read(promoCodeKey);
    print("Promo Code Id ==> $promoCode.");
    return promoCode;
  }

  static Future<void> saveFinalPrice(String finalPrice) async {
    bookingDataSaver.write(finalPriceKey, finalPrice);
    print("Final Price Saved ==> $finalPrice.");
  }

  static Future<String> getFinalPrice() async {
    var finalPrice = await bookingDataSaver.read(finalPriceKey);
    print("Final Price ==> $finalPrice.");
    return finalPrice;
  }

  static Future<void> saveAddressId(String addressId) async {
    bookingDataSaver.write(addressIdKey, addressId);
    print("Address ID Saved ==> $addressId.");
  }

  static Future<String> getAddressId() async {
    String addressId = await bookingDataSaver.read(addressIdKey);
    print("Address ID ==> $addressId.");
    return addressId;
  }

  static void clearSession() {
    bookingDataSaver.erase();
    print("Booking Session Cleared.");
  }
}
