import 'package:flutter/material.dart';
import 'package:hotel_booking_app/common_widgets/app_button.dart';
import 'package:hotel_booking_app/constants/app_colors.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';

class BookingCard extends StatelessWidget {
  final void Function()? onPressed;
  final String rates;
  const BookingCard({super.key, this.onPressed, required this.rates});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.grey))),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rates,
                style: AppTextStyles.f18W600Black,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "per night",
                style: AppTextStyles.f16W500Black,
              ),
            ],
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
            child: AppButton(
                onPressed: onPressed,
                borderRadius: 12,
                child: Text(
                  "Book Now",
                  style: AppTextStyles.f18W600White,
                )),
          )
        ],
      ),
    );
  }
}
