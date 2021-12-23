import 'package:get/get.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/services/api_helper.dart';
import 'package:ratibni_user/app/data/models/notifications_response.dart';

class NotificationsController extends GetxController {
  RxBool isButtonVisible = true.obs;
  RxBool isUserGuest = true.obs;
  final apiHelper = Get.find<ApiHelper>();
  RxList<NotificationList> notificationList = <NotificationList>[].obs;

  @override
  void onInit() {
    super.onInit();
    SessionManager.isUserTypeGuest().then(
      (isGuest) {
        isUserGuest.value = isGuest;
        if (!isUserGuest.value) getNotifications();
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getNotifications() {
    apiHelper.getNotifications().then(
      (response) {
        if (response.isOk) {
          NotificationResponse responseData =
              NotificationResponse.fromJson(response.body);
          notificationList.value = responseData.data;
        }
      },
    );
  }
}
