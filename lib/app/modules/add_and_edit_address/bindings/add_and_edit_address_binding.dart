import 'package:get/get.dart';

import '../controllers/add_and_edit_address_controller.dart';

class AddAndEditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAndEditAddressController>(
      () => AddAndEditAddressController(),
    );
  }
}
