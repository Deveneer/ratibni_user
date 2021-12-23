import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/app_strings.dart';
import 'package:ratibni_user/app/data/models/service_details_response.dart';
import 'package:ratibni_user/app/widgets/circular_rating_button.dart';
import 'package:ratibni_user/app/widgets/gap_widget.dart';

class CustomerReviewCard extends StatelessWidget {
  final Review review;

  const CustomerReviewCard({
    Key key,
    @required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightOrange,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                child: Image.network(
                  review.userprofile,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Icon(
                      Icons.person,
                      size: 36,
                      color: AppColors.lightBlue,
                    );
                  },
                ),
              ),
            ),
            HorizontalGap(gap: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  VerticalGap(gap: 2),
                  Text(
                    review?.message ?? AppStrings.notAvailable,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircularRatingButton(
                rating:
                    '${review.starCount.split('.').first}.${review.starCount.split('.')[1].split('').first}',
                isSmall: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}
