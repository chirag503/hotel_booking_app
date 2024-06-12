import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:hotel_booking_app/constants/app_colors.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/features/home/cubit/home_cubit.dart';
import 'package:hotel_booking_app/features/home/cubit/home_state.dart';
import 'package:hotel_booking_app/features/home/models/booking_model.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
import 'package:hotel_booking_app/features/home/widgets/amenties_widget.dart';
import 'package:hotel_booking_app/features/home/widgets/booking_card.dart';
import 'package:hotel_booking_app/features/home/widgets/check_in_out_widget.dart';
import 'package:hotel_booking_app/features/home/widgets/custom_image.dart';
import 'package:hotel_booking_app/features/home/widgets/people_count_chip.dart';
import 'package:hotel_booking_app/features/home/widgets/rating_card.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelItem data;
  final BookingModel? bookingData;
  final bool isBooked;
  const HotelDetailScreen({
    super.key,
    required this.data,
    this.isBooked = false,
    this.bookingData,
  });

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of<HomeCubit>(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _homeCubit.clearValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Details",
          style: AppTextStyles.f18W500White,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageSlideshow(
                    height: 300,
                    isLoop: true,
                    autoPlayInterval: 3000,
                    initialPage: 0,
                    indicatorColor: AppColors.kPrimaryBlue,
                    indicatorBackgroundColor: AppColors.grey,
                    children: (widget.data.photoList ?? [])
                        .map((e) => CustomImage(
                              e,
                              radius: 0,
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.data.hotelName ?? "NA"),
                          style: AppTextStyles.f28W700Black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                  "${widget.data.addressline1 ?? "NA"}, ${widget.data.city ?? "NA"}",
                                  style: AppTextStyles.f18W400Grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        RatingCard(
                            starRating: "${widget.data.starRating ?? 0}",
                            numberOfReviews:
                                "${widget.data.numberOfReviews ?? 0}"),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 16, bottom: widget.isBooked ? 0 : 16),
                            child: Amenties(data: widget.data.amenities ?? [])),
                        if (!widget.isBooked)
                          Amenties(
                            data: widget.data.roomType ?? [],
                            forRoom: true,
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            buildWhen: (previous, current) {
                              return current is CheckInOutDateSuccess ||
                                  current is ClearIntialValues;
                            },
                            builder: (context, state) {
                              return CheckInOutWidget(
                                checkInOut: widget.isBooked
                                    ? DateTimeRange(
                                        start: widget.bookingData?.startDate ??
                                            DateTime.now(),
                                        end: widget.bookingData?.endDate ??
                                            DateTime.now(),
                                      )
                                    : _homeCubit.checkInOutDate,
                                checkInOutTap: () {
                                  if (!widget.isBooked) {
                                    _homeCubit.checkInOutDatePick(
                                        context: context);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("No. of People:",
                                  style: AppTextStyles.f20W500Black),
                              widget.isBooked
                                  ? Text(
                                      "${widget.bookingData?.totalPerson ?? 0}",
                                      style: AppTextStyles.f20W500Black)
                                  : BlocBuilder<HomeCubit, HomeState>(
                                      buildWhen: (previous, current) {
                                        return current
                                                is IncrementPeopleCount ||
                                            current is DecrementPeopleCount ||
                                            current is ClearIntialValues;
                                      },
                                      builder: (context, state) {
                                        return PeopleCountChip(
                                          count: _homeCubit.peopleCount,
                                          add: () {
                                            _homeCubit.incrementPeopleCount();
                                          },
                                          sub: () {
                                            _homeCubit.decrementPeopleCount();
                                          },
                                        );
                                      },
                                    )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!widget.isBooked)
            BookingCard(
              rates: "₹${(widget.data.ratesFrom ?? 100) * 10}",
              onPressed: () {
                _homeCubit.bookHotel(widget.data);
              },
            )
        ],
      ),
    );
  }
}
