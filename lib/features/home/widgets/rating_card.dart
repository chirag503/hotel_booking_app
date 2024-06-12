import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';

class RatingCard extends StatelessWidget {
  final String starRating;
  final String numberOfReviews;
  const RatingCard({super.key, required this.starRating, required this.numberOfReviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: Colors.green),
          child: RichText(
              text: TextSpan(
                  text: starRating,
                  style: AppTextStyles.f14W600White,
                  children: [
                TextSpan(text: " / 5", style: AppTextStyles.f14W500White)
              ])),
        ),
        Text("$numberOfReviews Verified Ratings",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.f14W500Black),
      ],
    );
  }
}
