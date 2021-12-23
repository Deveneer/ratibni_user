import 'package:get/get.dart';

import '../controllers/book_service_details_controller.dart';

class BookServiceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookServiceDetailsController>(
      () => BookServiceDetailsController(),
    );
  }
}
