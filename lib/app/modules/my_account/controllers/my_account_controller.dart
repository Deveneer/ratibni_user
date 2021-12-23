import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';
import 'package:share_plus/share_plus.dart';

class MyAccountController extends GetxController {
  RxBool isFloatingMenuButtonOpen = false.obs;
  RxBool isFloatingButtonVisible = true.obs;
  RxBool isGuestUser = true.obs;
  final apiHelper = Get.find<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
    SessionManager.isUserTypeGuest().then(
      (isGuest) {
        isGuestUser.value = isGuest;
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToEditProfile() {
    Get.offNamed(Routes.EDIT_PROFILE);
  }

  void goToSavedAddresses() {
    Get.toNamed(
      Routes.ADDRESS,
      arguments: {'isFromMyAccountScreen': true},
    );
  }

  void goToChangePassword() {
    Get.toNamed(
      Routes.CHANGE_AND_RESET_PASSWORD,
      arguments: {'isFromChangePassword': true},
    );
  }

  void goToContactUs() {
    Get.toNamed(Routes.CONTACT_US);
  }

  void goToTermsAndCondition() {
    Get.toNamed(
      Routes.CONTENTS,
      arguments: {'contentType': '0'},
    );
  }

  void goToAboutUs() {
    Get.toNamed(
      Routes.CONTENTS,
      arguments: {'contentType': '1'},
    );
  }

  void goToPrivacyPolicy() {
    Get.toNamed(
      Routes.CONTENTS,
      arguments: {'contentType': '2'},
    );
  }

  void shareApp() {
    Share.share(
      AppStrings.shareAppContent,
    );
  }

  void logout() {
    apiHelper.logout().then(
      (response) {
        if (response.isOk) {
          BookingSessionManager.clearSession();
          SessionManager.clearSession();
          USER_TOKEN.value = '';
          USER_DETAILS.value = UserDetails();
          Get.offAllNamed(Routes.SPLASH);
        }
      },
    );
  }

  void login() {
    BookingSessionManager.clearSession();
    SessionManager.clearSession();
    SessionManager.saveUserTypeAsNonGuest();
    USER_TOKEN.value = '';
    USER_DETAILS.value = UserDetails();
    Get.offAllNamed(Routes.LOGIN_AND_SIGNUP);
  }
}
