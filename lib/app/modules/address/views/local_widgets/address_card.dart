import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/local_storage/sessions.dart';
import 'package:ratibni_user/app/modules/address/controllers/address_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class AddressCard extends StatelessWidget {
  final controller = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    TextStyle addressAndPhoneNumberTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w300,
    );
    return Obx(
      () => controller.isAddressListEmpty.value
          ? Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                AppStrings.addressNotAdded,
                style: Get.textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : ListView.builder(
              itemCount: controller.addressList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 180),
              itemBuilder: (context, index) => Stack(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                      child: Obx(
                        () => Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: index ==
                                      controller.selectedAddressCardIndex.value
                                  ? AppColors.lightBlue
                                  : Colors.black,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.editOrDeleteButtonLeftPosition.value =
                                  Get.width + 105;
                              controller.editOrDeleteButtonLeftPosition.value =
                                  Get.width - 80;
                              controller.selectButtonLeftPosition.value =
                                  Get.width + 105;
                              controller.selectButtonLeftPosition.value =
                                  Get.width - 105;
                              controller.selectedAddressCardIndex.value = index;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${GetUtils.capitalizeFirst(USER_DETAILS.value.firstName)} ${GetUtils.capitalizeFirst(USER_DETAILS.value.lastName) ?? ''}',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  VerticalGap(
                                    gap: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      '${controller.addressList[index].address} \n${controller.addressList[index].landmark}',
                                      style: addressAndPhoneNumberTextStyle,
                                    ),
                                  ),
                                  VerticalGap(
                                    gap: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      '${controller.addressList[index].city}, ${controller.addressList[index].state}, ${controller.addressList[index].country} - ${controller.addressList[index].zipcode}',
                                      style: addressAndPhoneNumberTextStyle,
                                    ),
                                  ),
                                  VerticalGap(
                                    gap: 5,
                                  ),
                                  Text(
                                    '${AppStrings.mobile}: ${USER_DETAILS.value.phoneNo}',
                                    style: addressAndPhoneNumberTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (controller.isFromMyAccountScreen)
                    Obx(
                      () => index == controller.selectedAddressCardIndex.value
                          ? AnimatedPositioned(
                              duration: Duration(milliseconds: 500),
                              left: controller
                                  .editOrDeleteButtonLeftPosition.value,
                              child: CircularButton(
                                AppStrings.edit.toUpperCase(),
                                size: 85,
                                buttonType: ButtonType.RIGHT,
                                textAlignment: Alignment.center,
                                onTap: () {
                                  controller.goToEditAddAddress(
                                    controller.addressList[index],
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ),
                  if (controller.isFromMyAccountScreen)
                    Obx(
                      () => index == controller.selectedAddressCardIndex.value
                          ? AnimatedPositioned(
                              duration: Duration(milliseconds: 500),
                              left: controller
                                  .editOrDeleteButtonLeftPosition.value,
                              bottom: 15,
                              child: CircularButton(
                                AppStrings.delete.toUpperCase(),
                                size: 85,
                                buttonType: ButtonType.RIGHT,
                                textAlignment: Alignment.center,
                                onTap: () {
                                  controller.deleteAddress(
                                    controller.addressList[index].id,
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ),
                  if (!controller.isFromMyAccountScreen)
                    Obx(
                      () => index == controller.selectedAddressCardIndex.value
                          ? AnimatedPositioned(
                              duration: Duration(milliseconds: 500),
                              left: controller.selectButtonLeftPosition.value,
                              child: CircularButton(
                                AppStrings.selected.toUpperCase(),
                                size: 130,
                                buttonType: ButtonType.RIGHT,
                                textAlignment: Alignment.centerLeft,
                                padding: 15,
                                onTap: () {},
                              ),
                            )
                          : Container(),
                    ),
                ],
              ),
            ),
    );
  }
}
