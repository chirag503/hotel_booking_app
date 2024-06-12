import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/utils/helper_methods.dart';

class Amenties extends StatelessWidget {
  final List<String> data;
  final bool forRoom;
  const Amenties({super.key, required this.data, this.forRoom = false});

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
          if (data.isNotEmpty)
            Text(
              forRoom ? "Room Types" : "Amenities",
              style: AppTextStyles.f20W500Black,
            ),
          const SizedBox(
            height: 16,
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.6),
            itemBuilder: (context, ind) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    forRoom
                        ? HelperMethods.getRoomTypeIcon(data[ind])
                        : HelperMethods.getAmenitiesIcon(data[ind]),
                    size: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    forRoom
                        ? HelperMethods.getRoomTypesString(data[ind])
                        : HelperMethods.getAmenitiesString(data[ind]),
                    style: AppTextStyles.f14W400Black,
                  )
                ],
              ),
            ),
            itemCount: data.length,
          )
        ],
      ),
    );
  }
}
