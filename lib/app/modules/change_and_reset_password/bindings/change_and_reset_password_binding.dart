import 'package:get/get.dart';

import '../controllers/change_and_reset_password_controller.dart';

class ChangeAndResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeAndResetPasswordController>(
      () => ChangeAndResetPasswordController(),
    );
  }
}
