import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class SearchController extends GetxController {
  RxBool shouldShowBackNavigationButton = true.obs;
  TextEditingController searchTextController = TextEditingController();
  RxList<ServiceDetails> searchDataList = <ServiceDetails>[].obs;
  RxBool isSearched = false.obs;
  RxBool isSearchHasData = true.obs;
  final apiHelper = Get.find<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void search() {
    apiHelper.search(searchTextController.text).then(
      (response) {
        if (response.isOk) {
          isSearched.value = true;
          ServiceDetailsResponse responseData =
              ServiceDetailsResponse.fromJson(response.body);
          searchTextController.text =
              responseData.data.length > 0 ? "" : searchTextController.text;
          isSearchHasData.value = responseData.data.length > 0 ? true : false;
          searchDataList.value = responseData.data;
        }
      },
    );
  }
}
