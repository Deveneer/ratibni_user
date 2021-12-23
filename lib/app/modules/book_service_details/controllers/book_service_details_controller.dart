import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ratibni_user/app/core/constants/app_error.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';

class BookServiceDetailsController extends GetxController {
  final Duration animationDuration = Duration(milliseconds: 500);
  final ServiceDetails serviceDetails = Get.arguments['serviceDetails'];
  final String categoryName = Get.arguments['categoryName'];
  final String categoryId = Get.arguments['categoryId'];

  TextEditingController quoteTextEditingController = TextEditingController();
  RxBool isBackButtonVisible = true.obs;
  RxDouble titleLeftPosition = (-Get.width).obs;
  RxDouble bookServiceActionButtonLeftPosition = (-Get.width).obs;
  RxInt currentSelectedIndexOfButton = 0.obs;
  RxBool isScheduleOrAsapButtonEnabled = false.obs;
  RxBool isScheduleEnabled = false.obs;
  RxString choosenYear = ''.obs;
  RxString choosenMonth = ''.obs;
  RxString choosenDay = ''.obs;
  RxString choosenTime = ''.obs;
  RxString multipleImagesName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    BookingSessionManager.saveBookingCategoryId(
      categoryId,
    );
    BookingSessionManager.saveBookingServiceId(
      serviceDetails.id.toString(),
    );
    // To clear the last saved Images as it is optional.
    BookingSessionManager.saveImagesForBooking(<String>[]);
  }

  @override
  void onReady() {
    super.onReady();
    titleLeftPosition.value = 30;
    bookServiceActionButtonLeftPosition.value = -40;
  }

  void enableScheduleOrAsapButton() {
    isScheduleOrAsapButtonEnabled.value = true;
    // For Request A Quote.
    BookingSessionManager.saveUserRequirement(
      quoteTextEditingController.text,
    );
  }

  takeMultipleImages() {
    ImagePicker().pickMultiImage().then(
      (pickedImages) {
        if (pickedImages != null) {
          List<String> pikedImagesPathList = [];
          multipleImagesName.value = "";
          for (XFile pickedImage in pickedImages) {
            pikedImagesPathList.add(pickedImage.path);
            multipleImagesName.value += pickedImage.path.split('/').last + ' ';
          }
          BookingSessionManager.saveImagesForBooking(pikedImagesPathList);
        }
      },
    ).onError(
      (error, stackTrace) {
        if (error == PlatformException) {
          Get.snackbar(
            ErrorText.cameraAccessDenied,
            ErrorText.cameraAccessDeniedDetails,
          );
        } else
          Get.snackbar(
            ApiErrors.unknownError,
            ApiErrors.unknownErrorDetails,
          );
      },
    );
  }

  void goToBookingSummary() {
    if (isScheduleEnabled.value) {
      if (choosenYear.value == '' ||
          choosenMonth.value == '' ||
          choosenDay.value == '' ||
          choosenTime.value == '') {
        Get.snackbar(
          AppStrings.dateAndTimeRequired,
          AppStrings.dateAndTimeRequiredDetails,
        );
      } else {
        if (DateTime.parse(
                '${choosenYear.value}-${TimeProvider.getMonth(choosenMonth.value)}-${choosenDay.value} ${choosenTime.value}:00')
            .isAfter(DateTime.now().add(Duration(days: 1)))) {
          BookingSessionManager.saveBookingDate(
            '${choosenYear.value}-${TimeProvider.getMonth(choosenMonth.value)}-${choosenDay.value}',
          );
          BookingSessionManager.saveBookingTime(
            choosenTime.value,
          ).then(
            (_) {
              serviceDetails.price != 0
                  ? Get.toNamed(
                      Routes.BOOKING_SUMMARY,
                      arguments: {
                        'serviceDetails': serviceDetails,
                      },
                    )
                  : Get.toNamed(
                      Routes.ADDRESS,
                      arguments: {
                        'isFromMyAccountScreen': false,
                      },
                    );
            },
          );
        } else {
          Get.snackbar(
            ApiErrors.invalidBookingDate,
            ApiErrors.invalidBookingDateDetails,
          );
        }
      }
    } else {
      BookingSessionManager.saveBookingDate(
        DateFormat('yyyy-MM-dd').format(
          DateTime.now().add(
            Duration(days: 1),
          ),
        ),
      );
      BookingSessionManager.saveBookingTime(
        DateFormat.Hm().format(DateTime.now()),
      ).then(
        (_) {
          serviceDetails.price != 0
              ? Get.toNamed(
                  Routes.BOOKING_SUMMARY,
                  arguments: {
                    'serviceDetails': serviceDetails,
                  },
                )
              : Get.toNamed(
                  Routes.ADDRESS,
                  arguments: {
                    'isFromMyAccountScreen': false,
                  },
                );
        },
      );
    }
  }
}
