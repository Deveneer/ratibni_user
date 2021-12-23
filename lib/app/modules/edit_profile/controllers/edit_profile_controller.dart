import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/data/models/login_and_signup_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class EditProfileController extends GetxController {
  RxDouble positionOfSaveChangesButtonRight = (-Get.width).obs;
  RxDouble positionOfHeaderTextFromLeft = (-Get.width).obs;
  Rx<File> profileImage = File('').obs;
  GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();

  final animationDuration = Duration(milliseconds: 500);
  final apiHelper = Get.find<ApiHelper>();
  final firstNameTextEditingController =
      TextEditingController(text: USER_DETAILS.value.firstName);
  final lastNameTextEditingController =
      TextEditingController(text: USER_DETAILS.value.lastName ?? '');
  final emailTextEditingController =
      TextEditingController(text: USER_DETAILS.value.email);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    positionOfSaveChangesButtonRight.value = -40;
    positionOfHeaderTextFromLeft.value = 30;
  }

  @override
  void onClose() {}

  Future getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      } else {
        profileImage.value = File('');
        print('No image selected.');
      }
    } catch (_) {
      Get.snackbar(
          ErrorText.cameraAccessDenied, ErrorText.cameraAccessDeniedDetails);
    }
  }

  updateProfile() {
    if (updateProfileFormKey.currentState.validate()) {
      Map<String, dynamic> requestMap = {
        'first_name':
            GetUtils.capitalizeFirst(firstNameTextEditingController.text),
        'last_name':
            GetUtils.capitalizeFirst(lastNameTextEditingController.text),
        'email': emailTextEditingController.text,
        if (profileImage?.value?.path != '')
          'image': MultipartFile(
            profileImage.value,
            filename: profileImage.value.path.split("/").last,
          ),
      };
      apiHelper.updateProfile(requestMap).then(
        (response) {
          if (response.isOk) {
            LoginAndSignUpResponse responseData =
                LoginAndSignUpResponse.fromJson(response.body);
            USER_DETAILS.value = responseData.data;
            SessionManager.saveUserDetails(USER_DETAILS.value);
            BotToast.showText(text: AppStrings.profileUpdated);
            Get.offNamed(Routes.MY_ACCOUNT);
          }
        },
      );
    }
  }
}
