import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:ratibni_user/app/widgets/floating_menu_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'package:get/get.dart';
import 'local_widgets/dashboard_action_card.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.blueButton,
          title: Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.yourLocation,
                      style: TextStyle(
                        fontSize: 16.8,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: Get.width * .43,
                      child: Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            controller.userCurrentLocation.value,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: controller.goToSearch
            ),
            IconButton(
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 25,
              ),
              onPressed: controller.goToNotifications,
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Get.height * (4.5 / 6.0),
              child: Stack(
                children: [
                  Obx(
                    () => AnimatedPositioned(
                      duration: Duration(milliseconds: 600),
                      top: controller.topPosition.value,
                      curve: Curves.bounceInOut,
                      child: Container(
                        width: Get.width,
                        height: Get.height * (4.5 / 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.blueButton,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      VerticalGap(
                        gap: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 36,
                        ),
                        child: Text(
                          AppStrings.ourServices,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      VerticalGap(
                        gap: 35,
                      ),
                      LimitedBox(
                        maxHeight: 175,
                        child: NotificationListener(
                          onNotification: (notification) {
                            if (notification is ScrollStartNotification) {
                              controller.isFloatingMenuButtonOpen.value = false;
                            }
                            return true;
                          },
                          child: Obx(
                            () => ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              itemCount:
                                  controller.serviceCategoriesList.length,
                              itemBuilder: (context, index) {
                                return DashboardActionCard(
                                  title: controller
                                          .serviceCategoriesList[index]?.name ??
                                      AppStrings.notAvailable,
                                  iconImage: controller
                                      .serviceCategoriesList[index]?.iconImage,
                                  onTap: () {
                                    controller.goToSelectedService(
                                      controller
                                          .serviceCategoriesList[index].id,
                                      controller
                                          .serviceCategoriesList[index].name,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FloatingMenuButton(
                    isOpen: controller.isFloatingMenuButtonOpen.value,
                    onToggle: (bool isOpen) {
                      controller.isFloatingMenuButtonOpen.value = isOpen;
                    },
                    currentNavigation: FloatingMenuButtonNavigation.HOME,
                    isSamePageNavigation: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
