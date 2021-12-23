import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class ContactUsController extends GetxController {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneNumberTextEditingController = TextEditingController();
  final queryTextEditingController = TextEditingController();
  final contactUsKey = GlobalKey<FormState>();
  final animationDuration = Duration(milliseconds: 600);
  final apiHelper = Get.find<ApiHelper>();

  RxDouble positionOfDoneButtonRight = (-Get.width).obs;
  RxDouble positionOfHeaderTextFromLeft = (-Get.width).obs;
  RxDouble positionOfForm = (Get.height).obs;
  RxBool isUserGuest = true.obs;

  @override
  void onInit() {
    super.onInit();
    SessionManager.isUserTypeGuest().then(
      (isGuest) {
        isUserGuest.value = isGuest;
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    animateWidgets(reverse: true);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onSubmitPressed() {
    Map<String, String> requestedMap = {
      'name': isUserGuest.value
          ? GetUtils.capitalizeFirst(nameTextEditingController.text)
          : GetUtils.capitalizeFirst(USER_DETAILS.value.firstName) +
              GetUtils.capitalizeFirst(USER_DETAILS.value.lastName),
      'email': isUserGuest.value
          ? emailTextEditingController.text
          : USER_DETAILS.value.email,
      'mobile': isUserGuest.value
          ? phoneNumberTextEditingController.text
          : USER_DETAILS.value.phoneNo,
      'query': queryTextEditingController.text,
      'user_id': isUserGuest.value ? "0" : USER_DETAILS.value.id.toString(),
    };

    if (contactUsKey.currentState.validate()) {
      apiHelper.contactUs(requestedMap).then(
        (response) {
          if (response.isOk) {
            BotToast.showText(
              text: AppStrings.querySubmittedSuccessfully,
            );
            Get.back();
          }
        },
      );
    }
  }

  void animateWidgets({bool reverse = false}) {
    positionOfDoneButtonRight.value = reverse ? -56 : -Get.width;
    positionOfForm.value = reverse ? 110 : Get.height;
    positionOfHeaderTextFromLeft.value = reverse ? 20 : -Get.width;
  }
}
