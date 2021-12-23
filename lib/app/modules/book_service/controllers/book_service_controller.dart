import 'package:get/get.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class BookServiceController extends GetxController {
  final animationDuration = Duration(milliseconds: 500);
  final apiHelper = Get.find<ApiHelper>();
  final String categoryId = Get.arguments['categoryId'];
  final String categoryName = Get.arguments['categoryName'];

  RxBool isServiceDetailsListEmpty = false.obs;
  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble serviceCardRightPosition = (-Get.width).obs;
  RxList<ServiceDetails> serviceDetailsList = <ServiceDetails>[].obs;

  @override
  void onInit() {
    super.onInit();
    getServiceDetails();
  }

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 30;
    serviceCardRightPosition.value = 0;
  }

  void getServiceDetails() {
    apiHelper.getServiceDetails(categoryId).then(
      (response) {
        if (response.isOk) {
          ServiceDetailsResponse responseData =
              ServiceDetailsResponse.fromJson(response.body);
          serviceDetailsList.value = responseData.data;
          isServiceDetailsListEmpty.value =
              responseData.data.length == 0 ? true : false;
        }
      },
    );
  }
}
