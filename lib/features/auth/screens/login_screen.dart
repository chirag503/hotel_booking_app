import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/common_widgets/app_button.dart';
import 'package:hotel_booking_app/common_widgets/common_textfeild.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/constants/image_path.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_cubit.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_state.dart';
import 'package:hotel_booking_app/features/auth/screens/sign_up_screen.dart';
import 'package:hotel_booking_app/features/home/screens/home_screen.dart';
import 'package:hotel_booking_app/router/anywhere_door.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = BlocProvider.of<AuthCubit>(context);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.clearLoginValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Image.asset(
                  ImagePath.loginImg,
                ),
              ),
              Text(
                'Welcome Back!',
                style: AppTextStyles.f28W700Black,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    CommonTextfeild(
                      controller: _authCubit.emailLoginController,
                      hintText: "Enter your email address",
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Basic email validation
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) {
                        return current is LoginObstructPassword;
                      },
                      builder: (context, state) {
                        return CommonTextfeild(
                          controller: _authCubit.passwordLoginController,
                          hintText: "Enter your password",
                          prefixIcon: Icons.lock,
                          obsecureText: _authCubit.loginObstructPassword,
                          onSuffixTap: () {
                            _authCubit.showHideLoginPassword();
                          },
                          suffixIcon: !_authCubit.loginObstructPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          AnywhereDoor.pushAndRemoveUntil(context,
                              className: const HomeScreen());
                        }
                      },
                      listenWhen: (previous, current) =>
                          current is LoginSuccess,
                      buildWhen: (previous, current) {
                        return current is LoginFailed ||
                            current is LoginSuccess ||
                            current is LoginLoading;
                      },
                      builder: (context, state) {
                        return _authCubit.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppButton(
                                onPressed: () async {
                                  final bool isValidate =
                                      _loginFormKey.currentState!.validate();
                                  await _authCubit.login(
                                      isValidate: isValidate, context: context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        AnywhereDoor.push(context,
                            className: const SignUpScreen());
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: AppTextStyles.f14W400Black,
                              children: [
                            TextSpan(
                                text: "Sign up here.",
                                style: AppTextStyles.f14W500Black)
                          ])),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
