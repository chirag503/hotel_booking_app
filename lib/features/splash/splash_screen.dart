import 'package:flutter/material.dart';
import 'package:hotel_booking_app/constants/image_path.dart';
import 'package:hotel_booking_app/features/auth/screens/login_screen.dart';
import 'package:hotel_booking_app/features/home/screens/home_screen.dart';
import 'package:hotel_booking_app/routes/anywhere_door.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;

  Future<void> checkAuth() async {
    prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("email");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        if (userId != null) {
          AnywhereDoor.pushReplacement(context, className: const HomeScreen());
        } else {
          AnywhereDoor.pushReplacement(context, className: const LoginScreen());
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImagePath.splashImg),
      ),
    );
  }
}
