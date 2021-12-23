import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/constants/assest_path.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/floating_menu_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:ratibni_user/app/widgets/menu_option.dart';
import '../controllers/my_account_controller.dart';

class MyAccountView extends GetView<MyAccountController> {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingMenuButton(
        currentNavigation: FloatingMenuButtonNavigation.PROFILE,
        isSamePageNavigation: false,
        isOpen: controller.isFloatingMenuButtonOpen.value,
        isVisible: controller.isFloatingButtonVisible.value,
        onToggle: (bool isOpen) {
          controller.isFloatingMenuButtonOpen.value = isOpen;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    controller.isFloatingButtonVisible.value = true;
                  } else if (notification is ScrollStartNotification) {
                    controller.isFloatingMenuButtonOpen.value = false;
                    controller.isFloatingButtonVisible.value = false;
                  }
                  return true;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          VerticalGap(
                            gap: 40,
                          ),
                          Text(
                            AppStrings.myAccount,
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Obx(
                            () => VerticalGap(
                              gap: !controller.isGuestUser.value ? 30 : 0,
                            ),
                          ),
                          Obx(
                            () => !controller.isGuestUser.value
                                ? _profileDetails(controller.goToEditProfile)
                                : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Divider(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: Get.height * .25),
                          child: Obx(
                            () => Column(
                              children: [
                                if (!controller.isGuestUser.value)
                                  MenuOption(
                                    icon: Icon(Icons.location_on_outlined),
                                    text: AppStrings.savedAddress,
                                    onTap: controller.goToSavedAddresses,
                                  ),
                                if (!controller.isGuestUser.value)
                                  MenuOption(
                                    icon: Icon(Icons.lock_outlined),
                                    text: AppStrings.changePassword,
                                    onTap: controller.goToChangePassword,
                                  ),
                                MenuOption(
                                  iconPath: AppImages.termAndConditions,
                                  text: AppStrings.termsAndCondition,
                                  onTap: controller.goToTermsAndCondition,
                                ),
                                MenuOption(
                                  icon: Icon(Icons.info_outline_rounded),
                                  text: AppStrings.aboutUs,
                                  onTap: controller.goToAboutUs,
                                ),
                                MenuOption(
                                  icon: Icon(Icons.privacy_tip_outlined),
                                  text: AppStrings.privacyPolicy,
                                  onTap: controller.goToPrivacyPolicy,
                                ),
                                MenuOption(
                                  icon: Icon(Icons.contact_support_outlined),
                                  text: AppStrings.contactUs,
                                  onTap: controller.goToContactUs,
                                ),
                                MenuOption(
                                  icon: Icon(Icons.share_outlined),
                                  text: AppStrings.shareApp,
                                  onTap: controller.shareApp,
                                ),
                                if (!controller.isGuestUser.value)
                                  MenuOption(
                                    icon: Icon(Icons.logout),
                                    text: AppStrings.logout,
                                    onTap: controller.logout,
                                  ),
                                if (controller.isGuestUser.value)
                                  MenuOption(
                                    icon: Icon(Icons.login),
                                    text: AppStrings.login,
                                    onTap: controller.login,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppBackButton(
              shouldShow: controller.isFloatingButtonVisible.value,
            )
          ],
        ),
      ),
    );
  }

  Widget _profileDetails(Function editProfile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightOrange,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  USER_DETAILS.value.imageUrl.toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.blueButton,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        HorizontalGap(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * .5,
              child: Text(
                '${GetUtils.capitalizeFirst(USER_DETAILS.value.firstName)} ${GetUtils.capitalizeFirst(USER_DETAILS.value.lastName) ?? ''}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.blueButton,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: Get.width * .5,
              child: Text(
                '${USER_DETAILS.value.email}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            VerticalGap(gap: 4),
            InkWell(
              onTap: editProfile,
              child: Container(
                width: Get.width * .5,
                child: Text(
                  AppStrings.editProfile,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.lightOrange,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
