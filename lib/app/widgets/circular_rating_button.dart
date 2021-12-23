import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';

class CircularRatingButton extends StatelessWidget {
  final String rating;
  final bool isSmall;

  const CircularRatingButton({
    Key key,
    @required this.rating,
    this.isSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isSmall ? Get.width * .1 : Get.width * .13,
      width: isSmall ? Get.width * .1 : Get.width * .13,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$rating ',
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 10 : 13,
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.white,
            size: isSmall ? 12 : 18,
          )
        ],
      ),
    );
  }
}
