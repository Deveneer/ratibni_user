import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';

// ignore: non_constant_identifier_names
Rx<String> USER_TOKEN = ''.obs;
// ignore: non_constant_identifier_names
Rx<UserDetails> USER_DETAILS = UserDetails().obs;

class SessionManager {
  static final userStorage = GetStorage();
  static final String userType = 'User Type';
  static final String nonGuestUser = 'Non Guest User';
  static final String guestUser = 'Guest User';
  static final String userToken = 'User Token';
  static final String userDetailsKey = 'User Details Key';

  static Future<void> saveUserTypeAsGuest() async {
    userStorage.write(userType, guestUser);
    print('USER TYPE SAVED ====> Guest User.');
  }

  static Future<void> saveUserTypeAsNonGuest() async {
    userStorage.write(userType, nonGuestUser);
    print('USER TYPE SAVED ====> Non Guest User.');
  }

  static Future<bool> isUserTypeGuest() async {
    bool isUserGuest = false;
    var savedUserType = await userStorage.read(userType);
    if (savedUserType == guestUser) isUserGuest = true;
    print('Is USER TYPE Guest =====> $isUserGuest.');
    return isUserGuest;
  }

  static Future<void> saveToken(String token) async {
    userStorage.write(userToken, token);
    print("User Token Saved ==> $token.");
  }

  static Future<String> getToken() async {
    String stringValue = await userStorage.read(userToken);
    print("User Token ==> $stringValue.");
    return stringValue;
  }

  static Future<void> saveUserDetails(UserDetails userData) async {
    userStorage.write(userDetailsKey, userData);
    print("User Details Saved ==> $userData.");
  }

  static Future<UserDetails> getUserDetails() async {
    var userDetails = await userStorage.read(userDetailsKey);
    print("User Details ==> $userDetails.");
    return UserDetails.fromJson(userDetails);
  }

  static void clearSession() {
    userStorage.erase();
    print("Session Cleared.");
  }
}
