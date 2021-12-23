import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:ratibni_user/app/widgets/menu_option.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerTextContainer(),
            bodyContainer(),
          ],
        ),
      ),
    );
  }

  Expanded bodyContainer() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: Get.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Form(
                key: controller.updateProfileFormKey,
                child: _profileDetails(),
              ),
            ),
          ),
          AppBackButton(
            shouldShow: true,
            customRoute: Routes.MY_ACCOUNT,
          ),
          Obx(
            () => AnimatedPositioned(
              duration: controller.animationDuration,
              right: controller.positionOfSaveChangesButtonRight.value,
              bottom: 15,
              child: CircularButton(
                AppStrings.saveChanges,
                onTap: controller.updateProfile,
                textAlignment: Alignment.centerLeft,
                padding: 30,
                size: 165,
                buttonType: ButtonType.LEFT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerTextContainer() {
    return Container(
      height: 130,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: controller.animationDuration,
              left: controller.positionOfHeaderTextFromLeft.value,
              bottom: 10,
              child: Text(
                AppStrings.myProfile,
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileDetails() {
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightOrange,
            ),
            child: Obx(
              () => ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: controller.profileImage?.value?.path == ''
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.blueButton,
                      )
                    : Image.file(
                        controller.profileImage.value,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showChooser();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppStrings.editProfilePicture,
                style: TextStyle(
                  color: AppColors.blueButton,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            controller: controller.firstNameTextEditingController,
            keyboardType: TextInputType.name,
            borderCursorAndTextColor: AppColors.lightBlue,
            labelText: AppStrings.firstName,
            validatorErrorText: ErrorText.firstNameErrorText,
          ),
          VerticalGap(gap: 20),
          UniversalTextField(
            controller: controller.lastNameTextEditingController,
            keyboardType: TextInputType.name,
            borderCursorAndTextColor: AppColors.lightBlue,
            labelText: AppStrings.lastName,
            validatorErrorText: ErrorText.lastNameErrorText,
          ),
          VerticalGap(gap: 20),
          EmailTextField(
            controller: controller.emailTextEditingController,
            borderCursorAndTextColor: AppColors.lightBlue,
          ),
          VerticalGap(
            gap: Get.height * .7,
          ),
        ],
      ),
    );
  }

  showChooser() {
    showModalBottomSheet(
      context: Get.context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                AppStrings.chooseImageFrom,
                style: TextStyle(
                  color: AppColors.blueButton,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            MenuOption(
              icon: Icon(
                Icons.camera,
                color: AppColors.lightOrange,
              ),
              text: AppStrings.camera,
              onTap: () {
                controller.getImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            MenuOption(
              icon: Icon(
                Icons.image,
                color: AppColors.lightOrange,
              ),
              text: AppStrings.gallery,
              onTap: () {
                controller.getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
