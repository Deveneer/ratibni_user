import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/floating_button_positions.dart';
import 'package:ratibni_user/app/data/local_storage/booking_session_manager.dart';
import 'package:ratibni_user/app/data/models/address_response.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';
import 'package:ratibni_user/app/services/api_helper.dart';

class AddressController extends GetxController {
  final bool isFromMyAccountScreen = Get.arguments['isFromMyAccountScreen'];
  RxBool isFloatingButtonsVisible = true.obs;
  RxDouble mainFloatingButtonRightPosition = hideCircularButtonLeftPosition.obs;
  RxDouble addAddressButtonLeftPostion = (-Get.width).obs;
  RxInt selectedAddressCardIndex = (-1).obs;
  RxDouble selectButtonLeftPosition = (Get.width + 105).obs;
  RxDouble editOrDeleteButtonLeftPosition = (Get.width + 105).obs;
  RxBool isAddressListEmpty = false.obs;
  RxList<Address> addressList = <Address>[].obs;

  final apiHelper = Get.find<ApiHelper>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 0)).then(
      (value) {
        mainFloatingButtonRightPosition.value = showCircularButtonLeftPosition;
        addAddressButtonLeftPostion.value = -30.0;
      },
    );
    getAddress();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getAddress() {
    apiHelper.getAddress().then(
      (response) {
        if (response.isOk) {
          AddressResponse responseData =
              AddressResponse.fromJson(response.body);
          addressList.value = responseData.data;
          isAddressListEmpty.value =
              responseData.data.length == 0 ? true : false;
        }
      },
    );
  }

  void goToAddAddress() {
    Get.toNamed(Routes.ADD_AND_EDIT_ADDRESS);
  }

  void goToEditAddAddress(Address selectedAddressDetails) {
    Get.toNamed(
      Routes.ADD_AND_EDIT_ADDRESS,
      arguments: {
        'addressDetails': selectedAddressDetails,
      },
    );
  }

  void deleteAddress(int addressId) {
    Map<String, String> requestMap = {
      'address_id': addressId.toString(),
    };
    apiHelper.deleteAddress(requestMap).then(
      (response) {
        if (response.isOk) {
          BotToast.showText(text: AppStrings.addressDeleted);
          getAddress();
        }
      },
    );
  }

  void saveAddressAndGoToConfirmBooking() {
    if (selectedAddressCardIndex.value != -1) {
      BookingSessionManager.saveAddressId(
        addressList[selectedAddressCardIndex.value].id.toString(),
      );
      Get.toNamed(
        Routes.CONFIRM_BOOKING,
        arguments: {
          'addressDetails': addressList[selectedAddressCardIndex.value]
        },
      );
    } else {
      Get.snackbar(
        AppStrings.addressNotSelected,
        AppStrings.addressNotSelectedDetails,
      );
    }
  }
}
