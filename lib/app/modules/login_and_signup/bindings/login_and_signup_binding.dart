import 'package:get/get.dart';

import '../controllers/login_and_signup_controller.dart';

class LoginAndSignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginAndSignupController>(
      () => LoginAndSignupController(),
    );
  }
}
