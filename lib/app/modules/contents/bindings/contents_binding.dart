import 'package:get/get.dart';

import '../controllers/contents_controller.dart';

class ContentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentsController>(
      () => ContentsController(),
    );
  }
}
