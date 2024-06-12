import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_cubit.dart';
import 'package:hotel_booking_app/features/auth/models/user_model.dart';
import 'package:hotel_booking_app/features/booking/cubit/booking_cubit.dart';
import 'package:hotel_booking_app/features/home/cubit/home_cubit.dart';
import 'package:hotel_booking_app/features/home/models/booking_model.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
import 'package:hotel_booking_app/features/splash/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(HotelItemAdapter());
  Hive.registerAdapter(BookingModelAdapter());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => BookingCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
