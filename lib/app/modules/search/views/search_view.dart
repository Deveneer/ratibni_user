import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/text_fields.dart';
import 'package:ratibni_user/app/widgets/back_button.dart';
import 'package:ratibni_user/app/widgets/book_service_detail_card.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: SearchTextField(
                controller: controller.searchTextController,
                borderAndCursorColor: AppColors.blueButton,
                search: controller.search,
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: NotificationListener(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
                          controller.shouldShowBackNavigationButton.value =
                              true;
                        } else if (notification is ScrollStartNotification) {
                          controller.shouldShowBackNavigationButton.value =
                              false;
                        }
                        return true;
                      },
                      child: Obx(
                        () => !controller.isSearched.value
                            ? Center(
                                child: Text(
                                  AppStrings.searchServiceWhichYouWant,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : controller.isSearchHasData.value
                                ? BookServiceDetailCard(
                                    serviceDetailsList:
                                        controller.searchDataList,
                                  )
                                : Center(
                                    child: Text(
                                      AppStrings.noResultsFound,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AppBackButton(
                      shouldShow:
                          controller.shouldShowBackNavigationButton.value,
                    ),
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
