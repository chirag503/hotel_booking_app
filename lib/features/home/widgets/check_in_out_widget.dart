import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:intl/intl.dart';

class CheckInOutWidget extends StatelessWidget {
  final DateTimeRange? checkInOut;
  final void Function() checkInOutTap;

  const CheckInOutWidget({
    super.key,
    required this.checkInOut,
    required this.checkInOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Dates", style: AppTextStyles.f20W500Black),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: checkInOutTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCheckInField(
                  label: 'Check in',
                  time: checkInOut?.start,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CustomCheckInField(
                    label: 'Check out',
                    time: checkInOut?.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCheckInField extends StatelessWidget {
  const CustomCheckInField({
    super.key,
    required this.label,
    required this.time,
  });

  final String label;
  final DateTime? time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_month),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.f18W500Black,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
                time != null ? DateFormat.yMMMd().format(time!) : "Select time",
                style: AppTextStyles.f16W500Grey)
          ],
        ),
      ],
    );
  }
}
