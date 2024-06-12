import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/app_colors.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
import 'package:hotel_booking_app/features/home/widgets/custom_image.dart';

class HotelBookingWidget extends StatelessWidget {
  const HotelBookingWidget({
    super.key,
    this.onTap,
    required this.data,
  });

  final void Function()? onTap;
  final HotelItem data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(14),
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
        child: Row(
          children: [
            CustomImage(
              data.photo ?? "",
              width: 150,
              height: 150,
              radius: 15,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (data.hotelName ?? "NA"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.f18W500Black,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          data.city ?? "NA",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.f16W500Black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "${data.starRating ?? 0}",
                        style: AppTextStyles.f14W600White,
                        children: [
                          TextSpan(
                            text: "/5",
                            style: AppTextStyles.f14W500White,
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "₹${(data.ratesFrom ?? 100) * 10} ",
                      style: AppTextStyles.f18W600Black,
                      children: [
                        TextSpan(
                          text: " per night",
                          style: AppTextStyles.f16W500Grey,
                        ),
                      ],
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
