import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/app_colors.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';

class PeopleCountChip extends StatelessWidget {
  final int count;
  final void Function()? add;
  final void Function()? sub;
  const PeopleCountChip({super.key, required this.count, this.add, this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.grey)),
      child: Row(
        children: [
          IconButton(
              onPressed: sub,
              icon: const Icon(Icons.remove, color: Colors.black)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              count.toString(),
              style: AppTextStyles.f16W500Black,
            ),
          ),
          IconButton(
              onPressed: add,
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
