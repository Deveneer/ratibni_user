import 'package:get/get.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';

class SplashController extends GetxController {
  RxDouble positionGetStarted = (-200.0).obs; //-40
  RxDouble positionContinueAsGuest = (-200.0).obs; //-40
  RxDouble positionLanguage = (-200.0).obs; //30
  final animationDuration = Duration(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
    SessionManager.getToken().then(
      (token) {
        if (token != null) {
          USER_TOKEN.value = token;
          SessionManager.getUserDetails().then(
            (data) {
              USER_DETAILS.value = data;
            },
          );
          goToDashboardIfAlreadyLoggedIn();
        }
      },
    );

    Future.delayed(animationDuration * 2, changePositions);
  }

  void changePositions() {
    positionGetStarted.value = -20;
    positionContinueAsGuest.value = -20;
    positionLanguage.value = 30;
  }

  // Navigate to Login Screen with animation.
  void goToLogin({bool isGuest}) {
    positionGetStarted.value = -200;
    positionContinueAsGuest.value = -200;
    positionLanguage.value = -200;

    SessionManager.saveUserTypeAsNonGuest();
    Future.delayed(animationDuration).then(
      (_) {
        Get.offAllNamed(
          Routes.LOGIN_AND_SIGNUP,
        );
      },
    );
  }

  // Navigate to Dashboard with animation.
  void goToDashboard() {
    positionGetStarted.value = -200;
    positionContinueAsGuest.value = -200;
    positionLanguage.value = -200;

    SessionManager.saveUserTypeAsGuest();
    Future.delayed(animationDuration).then(
      (value) {
        Get.offAllNamed(
          Routes.DASHBOARD,
        );
      },
    );
  }

  void goToDashboardIfAlreadyLoggedIn() {
    positionGetStarted.value = -200;
    positionContinueAsGuest.value = -200;
    positionLanguage.value = -200;

    SessionManager.saveUserTypeAsNonGuest();
    Future.delayed(animationDuration).then(
      (value) {
        Get.offAllNamed(
          Routes.DASHBOARD,
        );
      },
    );
  }
}
