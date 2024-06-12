import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/constants/image_path.dart';
import 'package:hotel_booking_app/features/booking/cubit/booking_cubit.dart';
import 'package:hotel_booking_app/features/booking/cubit/booking_state.dart';
import 'package:hotel_booking_app/features/booking/widgets/hotel_booking_widget.dart';
import 'package:hotel_booking_app/features/home/screens/hotel_detail_screen.dart';
import 'package:hotel_booking_app/router/anywhere_door.dart';
import 'package:lottie/lottie.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late BookingCubit _bookingCubit;

  @override
  void initState() {
    super.initState();
    _bookingCubit = BlocProvider.of<BookingCubit>(context);
    _bookingCubit.getBookingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Your Bookings",
            style: AppTextStyles.f18W500White,
          )),
      body: BlocBuilder<BookingCubit, BookingState>(
        buildWhen: (previous, current) {
          return current is BookingListFailed ||
              current is BookingListSuccess ||
              current is BookingListLoading;
        },
        builder: (context, state) {
          if (state is BookingListFailed) {
            return Center(
              child: SizedBox(
                child: LottieBuilder.asset(ImagePath.errorLottie),
              ),
            );
          }

          if (state is BookingListLoading) {
            return Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(ImagePath.loadingLottie),
                    Text("Loading...", style: AppTextStyles.f28W700Black),
                  ],
                ),
              ),
            );
          }

          return (_bookingCubit.bookingList.isEmpty)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(ImagePath.noDataLottie),
                  Text("No Data Found", style: AppTextStyles.f20W500Black),
                  Text("Please Book the Hotels",
                      style: AppTextStyles.f20W500Black),
                ],
              )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return HotelBookingWidget(
                              onTap: () {
                                AnywhereDoor.push(context,
                                    className: HotelDetailScreen(
                                      isBooked: true,
                                      data: _bookingCubit
                                          .bookingList[index].hotelData,
                                      bookingData:
                                          _bookingCubit.bookingList[index],
                                    ));
                              },
                              data: _bookingCubit.bookingList[index].hotelData,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: _bookingCubit.bookingList.length),
                    )
                  ],
                );
        },
      ),
    );
  }
}
