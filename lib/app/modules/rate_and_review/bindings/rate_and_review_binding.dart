import 'package:get/get.dart';

import '../controllers/rate_and_review_controller.dart';

class RateAndReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateAndReviewController>(
      () => RateAndReviewController(),
    );
  }
}
