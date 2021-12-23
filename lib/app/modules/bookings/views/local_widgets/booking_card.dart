import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/core/utils/date_time_provider.dart';
import 'package:ratibni_user/app/data/models/my_bookings_response.dart';
import 'package:ratibni_user/app/modules/bookings/controllers/bookings_controller.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class BookingCard extends StatelessWidget {
  final bookingsController = Get.find<BookingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => bookingsController.currentSelectedIndex.value == 0
        ? bookingsController.isOngoingBookingsAvailable.value
            ? bookingCardsList(bookingsController.ongoingBookingsList)
            : bookingNotAvailable(AppStrings.ongoingBookingNotAvailable)
        : bookingsController.isCompletedBookingsAvailable.value
            ? bookingCardsList(bookingsController.completedBookingsList)
            : bookingNotAvailable(AppStrings.pastBookingNotAvailable));
  }

  ListView bookingCardsList(List<BookingDetails> bookingData) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      shrinkWrap: true,
      itemCount: bookingData.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    bookingsController
                        .goToBookingDetailsScreen(bookingData[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    width: Get.width - 48,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.blueButton),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppStrings.bookingId}: ${bookingData[index].bookingId}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.blueButton,
                            fontSize: 17,
                          ),
                        ),
                        VerticalGap(gap: 6),
                        Text(
                          bookingData[index].getService.serviceName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        VerticalGap(gap: 3),
                        Text(
                          '${AppStrings.bookedFor} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(bookingData[index].bookingDate))} - ${DateFormat.Hm().format(TimeProvider.getTime(bookingData[index].bookingTime))}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        VerticalGap(gap: 16),
                        if (bookingData[index].status != '0' &&
                            bookingData[index].status != '5')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Container(
                                  color: AppColors.lightOrange,
                                  width: 25,
                                  height: 25,
                                  child: Image.network(
                                    'https://unsplash.com/photos/peaTniZsUQs',
                                    errorBuilder: (_, __, ___) {
                                      return Icon(
                                        Icons.person,
                                        size: 15,
                                      );
                                    },
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              HorizontalGap(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Best Cleaner',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  VerticalGap(
                                    gap: 2,
                                  ),
                                  LimitedBox(
                                    maxWidth: Get.width * 0.6,
                                    child: Text(
                                      '3+ Years Experience \n4.3 Ratings(71 Reviews)',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.lightOrange,
                                      ),
                                    ),
                                  ),
                                  VerticalGap(
                                    gap: 15,
                                  )
                                ],
                              ),
                            ],
                          ),
                        if (bookingData[index].status == '0' ||
                            bookingData[index].status == '5')
                          VerticalGap(
                            gap: 60,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (bookingData[index].status == '0' ||
                                bookingData[index].status == '1' ||
                                bookingData[index].status == '2' ||
                                bookingData[index].status == '3')
                              Text(
                                '${AppStrings.otp.toUpperCase()}: ${bookingData[index].bookingOtp}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.lightOrange,
                                  fontSize: 15,
                                ),
                              ),
                            Text(
                              bookingsController.bookingStatusMessageList[
                                  int.parse(bookingData[index].status)],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: bookingData[index].status == '5'
                                    ? Colors.red
                                    : AppColors.lightOrange,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (bookingData[index].status != '0' &&
                    bookingData[index].status != '5')
                  Positioned(
                    right: -30,
                    child: CircularButton(
                      bookingData[index].status == '4'
                          ? AppStrings.rateAndReview
                          : AppStrings.view,
                      size: 125,
                      buttonType: ButtonType.RIGHT,
                      textAlignment: Alignment.centerLeft,
                      padding: 15,
                      onTap: () {
                        bookingData[index].status == '4'
                            ? bookingsController.goToRateAndReview(
                                bookingData[index].servicesId,
                                bookingData[index].providerId,
                              )
                            : bookingsController.goToBookingDetailsScreen(
                                bookingData[index],
                              );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Padding bookingNotAvailable(notAvailableText) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        notAvailableText,
        style: Get.textTheme.headline6.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
