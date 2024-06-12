import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/common_widgets/common_textfeild.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/constants/image_path.dart';
import 'package:hotel_booking_app/features/auth/screens/login_screen.dart';
import 'package:hotel_booking_app/features/booking/screens/booking_screen.dart';
import 'package:hotel_booking_app/features/home/cubit/home_cubit.dart';
import 'package:hotel_booking_app/features/home/cubit/home_state.dart';
import 'package:hotel_booking_app/features/home/screens/hotel_detail_screen.dart';
import 'package:hotel_booking_app/features/home/widgets/hotel_card.dart';
import 'package:hotel_booking_app/routes/anywhere_door.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.getHotelsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          "Hotel Booky",
          style: AppTextStyles.f18W500White,
        ),
        actions: [
          IconButton(
              onPressed: () {
                AnywhereDoor.push(context, className: const BookingScreen());
              },
              icon: const Icon(Icons.bookmark_added_sharp)),
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                // ignore: use_build_context_synchronously
                AnywhereDoor.pushReplacement(context,
                    className: const LoginScreen());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: SearchTextfeild(
                  onChanged: (p0) {
                    _homeCubit.searchHotels(p0);
                  },
                  hintText: "Search by city and name",
                  prefixIcon: Icons.search),
            ),
            BlocBuilder<HomeCubit, HomeState>(buildWhen: (previous, current) {
              return current is HotelDataLoading ||
                  current is HotelDataSuccess ||
                  current is HotelDataFailed ||
                  current is SearchHotelDataLoading ||
                  current is SearchHotelDataSuccess ||
                  current is SearchHotelDataFailed;
            }, builder: (context, state) {
              if (state is SearchHotelDataLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(ImagePath.searchLottie),
                      Text("Searching...", style: AppTextStyles.f28W700Black),
                    ],
                  ),
                );
              }

              if (state is HotelDataLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(ImagePath.loadingLottie),
                      Text("Loading...", style: AppTextStyles.f28W700Black),
                    ],
                  ),
                );
              }

              if (state is HotelDataFailed || state is SearchHotelDataFailed) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: LottieBuilder.asset(ImagePath.errorLottie),
                );
              }

              return (_homeCubit.hotelsList.isEmpty ||
                      (_homeCubit.hotelsSearchList.isEmpty &&
                          _homeCubit.isSearchMode))
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(ImagePath.noDataLottie),
                        Text("No Hotels Found",
                            style: AppTextStyles.f20W500Black),
                      ],
                    )
                  : Expanded(
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return HotelCard(
                              item: _homeCubit.isSearchMode
                                  ? _homeCubit.hotelsSearchList[index]
                                  : _homeCubit.hotelsList[index],
                              onTap: () {
                                AnywhereDoor.push(context,
                                    className: HotelDetailScreen(
                                        data: _homeCubit.isSearchMode
                                            ? _homeCubit.hotelsSearchList[index]
                                            : _homeCubit.hotelsList[index]));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: _homeCubit.isSearchMode
                              ? _homeCubit.hotelsSearchList.length
                              : _homeCubit.hotelsList.length),
                    );
            })
          ],
        ),
      ),
    );
  }
}
