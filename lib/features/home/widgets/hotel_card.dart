import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_booking_app/constants/app_colors.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
import 'package:hotel_booking_app/features/home/widgets/custom_image.dart';
import 'package:hotel_booking_app/features/home/widgets/rating_card.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
    this.onTap,
    required this.item,
  });

  final void Function()? onTap;
  final HotelItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 350,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.hotelName ?? "NA",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.f18W500Black),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(item.city ?? "NA",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.f16W500Black),
                        ),
                      ],
                    ),
                  ),
                  RatingCard(
                      starRating: "${item.starRating ?? 0}",
                      numberOfReviews: "${item.numberOfReviews ?? 0}"),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("₹${(item.ratesFrom ?? 100) * 10}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.f18W600Black),
                        const SizedBox(
                          height: 3,
                        ),
                        Text("per night",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.f16W500Grey),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CustomImage(
      item.photo ?? "",
      width: double.infinity,
      height: 180,
      radius: 15,
    );
  }
}
