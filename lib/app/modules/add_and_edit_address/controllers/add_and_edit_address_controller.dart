import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/models/address_response.dart';
import 'package:ratibni_user/app/modules/address/controllers/address_controller.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class AddAndEditAddressController extends GetxController {
  final addressController = Get.find<AddressController>();
  final Address addressDetails =
      Get.arguments == null ? null : Get.arguments['addressDetails'];
  final addressFormKey = GlobalKey<FormState>();

  ApiHelper apiHelper = Get.find<ApiHelper>();
  RxDouble positionOfHeaderText = (-Get.width).obs;
  RxDouble positionOfSaveAndUpdateButtonRight = (-Get.width).obs;
  RxBool isFloatingBackButtonsVisible = true.obs;

  TextEditingController addressTextController;
  TextEditingController landmarkTextController;
  TextEditingController cityTextController;
  TextEditingController stateTextController;
  TextEditingController countryTextController;
  TextEditingController postalCodeTextController;

  @override
  void onInit() {
    super.onInit();
    addressTextController =
        TextEditingController(text: addressDetails?.address ?? '');
    landmarkTextController =
        TextEditingController(text: addressDetails?.landmark ?? '');
    cityTextController =
        TextEditingController(text: addressDetails?.city ?? '');
    stateTextController =
        TextEditingController(text: addressDetails?.state ?? '');
    countryTextController =
        TextEditingController(text: addressDetails?.country ?? '');
    postalCodeTextController =
        TextEditingController(text: addressDetails?.zipcode ?? '');
  }

  @override
  void onReady() {
    super.onReady();
    positionOfSaveAndUpdateButtonRight.value = -35;
    positionOfHeaderText.value = 30;
  }

  @override
  void onClose() {}

  void addAddress() {
    Map<String, String> requestMap = {
      'address': addressTextController.text,
      'landmark': landmarkTextController.text,
      'city': cityTextController.text,
      'state': stateTextController.text,
      'country': countryTextController.text,
      'zipcode': postalCodeTextController.text,
    };
    if (addressFormKey.currentState.validate()) {
      apiHelper.addAddress(requestMap).then(
        (response) {
          if (response.isOk) {
            BotToast.showText(
              text: AppStrings.addressAdded,
            );
            Get.back();
            addressController.getAddress();
          }
        },
      );
    }
  }

  void updateAddress() {
    Map<String, String> requestMap = {
      'address': addressTextController.text,
      'landmark': landmarkTextController.text,
      'city': cityTextController.text,
      'state': stateTextController.text,
      'country': countryTextController.text,
      'zipcode': postalCodeTextController.text,
      'address_id': addressDetails.id.toString(),
    };
    if (addressFormKey.currentState.validate()) {
      apiHelper.editAddress(requestMap).then(
        (response) {
          if (response.isOk) {
            BotToast.showText(
              text: AppStrings.addressUpdated,
            );
            Get.back();
            addressController.getAddress();
          }
        },
      );
    }
  }
}
