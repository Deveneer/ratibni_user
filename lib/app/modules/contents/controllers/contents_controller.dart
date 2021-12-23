import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/data/models/about_us_response.dart';
import 'package:ratibni_user/app/data/models/privacy_policy_response.dart';
import 'package:ratibni_user/app/data/models/terms_and_condition_response.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class ContentsController extends GetxController {
  final apiHelper = Get.find<ApiHelper>();
  RxString content = ''.obs;
  String contentType = Get.arguments['contentType'];
  // Content Type = 0 for Terms & Condition.
  // Content Type = 1 for About Us.
  // Content Type = 2 for Privacy Policy.

  @override
  void onInit() {
    super.onInit();
    if (contentType == '0')
      getTermsAndCondition();
    else if (contentType == '1')
      getAboutUs();
    else
      getPrivacyPolicy();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getTermsAndCondition() {
    apiHelper.getTermsAndCondition().then(
      (response) {
        if (response.isOk) {
          TermsAndConditionResponse responseData =
              TermsAndConditionResponse.fromJson(response.body);
          content.value = responseData.data.termAndCondition;
        } else
          content.value = ErrorText.noDataFound;
      },
    );
  }

  void getAboutUs() {
    apiHelper.getAboutUs().then(
      (response) {
        if (response.isOk) {
          AboutUsResponse responseData =
              AboutUsResponse.fromJson(response.body);
          content.value = responseData.data.aboutDescription;
        } else
          content.value = ErrorText.noDataFound;
      },
    );
  }

  void getPrivacyPolicy() {
    apiHelper.getPrivacyPolicy().then(
      (response) {
        if (response.isOk) {
          PrivacyPolicyResponse responseData =
              PrivacyPolicyResponse.fromJson(response.body);
          content.value = responseData.data.privacyPolicy;
        } else
          content.value = ErrorText.noDataFound;
      },
    );
  }
}
