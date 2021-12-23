import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/widgets/circular_button.dart';
import 'package:ratibni_user/app/widgets/circular_rating_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';
import 'circular_button.dart';
import 'package:ratibni_user/app/routes/app_pages.dart';

class BookServiceDetailCard extends StatelessWidget {
  final List<ServiceDetails> serviceDetailsList;
  const BookServiceDetailCard({
    Key key,
    @required this.serviceDetailsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 110),
      shrinkWrap: true,
      itemCount: serviceDetailsList.length,
      itemBuilder: (context, index) {
        return Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: InkWell(
                  onTap: () {
                    goToBookASerivce(
                      serviceDetailsList[index],
                    );
                  },
                  child: Container(
                    width: Get.width * .86,
                    height: 190,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blueButton,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 100, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceDetailsList[index].serviceName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          VerticalGap(
                            gap: 1,
                          ),
                          if (serviceDetailsList[index].discountPrice != 0)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${AppStrings.price}: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: serviceDetailsList[index]
                                        .discountPrice
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${AppStrings.currency}   ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: serviceDetailsList[index]
                                        .discountPrice
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${AppStrings.currency}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          VerticalGap(
                            gap: 10,
                          ),
                          Text(
                            serviceDetailsList[index].description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.lightBlue,
                              fontSize: 15.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    child: bookServiceOrRequestQuoteButton(
                      serviceDetailsList[index],
                    ),
                    right: -Get.width * .11,
                  ),
                  if (serviceDetailsList[index].rating != null &&
                      serviceDetailsList[index].rating != "1.0")
                    Positioned(
                      child: CircularRatingButton(
                        rating: serviceDetailsList[index].rating,
                      ),
                      right: Get.width * 0.07,
                      bottom: 20,
                    ),
                  Container(
                    height: 210,
                    width: Get.width + 10,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget bookServiceOrRequestQuoteButton(ServiceDetails serviceDetails) {
    return CircularButton(
      serviceDetails.discountPrice != 0
          ? AppStrings.bookAService
          : AppStrings.requestAQuote,
      onTap: () {
        goToBookASerivce(serviceDetails);
      },
      size: 160,
      padding: serviceDetails.discountPrice != 0 ? 30 : 20,
      textAlignment: Alignment.centerLeft,
    );
  }

  void goToBookASerivce(ServiceDetails serviceDetails) {
    Get.toNamed(
      Routes.BOOK_SERVICE_DETAILS,
      arguments: {
        'serviceDetails': serviceDetails,
        'categoryName': serviceDetails.categoryName,
        'categoryId': serviceDetails.categoryId.toString(),
      },
    );
  }
}
