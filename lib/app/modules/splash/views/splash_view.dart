import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/constants/assest_path.dart';
import 'package:ratibni_user/app/modules/splash/controllers/splash_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'local_widgets/language_button.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white, // transparent status bar
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 161,
                    width: 82,
                    child: Image.asset(AppImages.ratibniSplash),
                  ),
                ),
                Obx(
                  () => AnimatedPositioned(
                    duration: controller.animationDuration,
                    top: 35,
                    left: controller.positionGetStarted.value,
                    child: CircularButton(
                      AppStrings.getStarted,
                      onTap: () {
                        controller.goToLogin(isGuest: false);
                      },
                      size: 180,
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedPositioned(
                    duration: controller.animationDuration,
                    bottom: 65,
                    right: controller.positionContinueAsGuest.value,
                    child: CircularButton(
                      AppStrings.continueAsGuest,
                      onTap: () {
                        controller.goToDashboard();
                      },
                      size: 180,
                    ),
                  ),
                ),
                Obx(
                  () => AnimatedPositioned(
                    duration: controller.animationDuration,
                    left: 20,
                    bottom: controller.positionLanguage.value,
                    child: LanguageButton(
                      onSelect: (language) {
                        if (language == "Ar") {
                          BotToast.showText(text: AppStrings.comingSoon);
                        } else {
                          BotToast.showText(text: AppStrings.alreadyInEng);
                        }
                        print("Selected Language $language");
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
