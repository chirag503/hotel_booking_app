import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/common_widgets/app_button.dart';
import 'package:hotel_booking_app/common_widgets/common_textfeild.dart';
import 'package:hotel_booking_app/constants/app_text_styles.dart';
import 'package:hotel_booking_app/constants/image_path.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_cubit.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_state.dart';
import 'package:hotel_booking_app/features/auth/screens/login_screen.dart';
import 'package:hotel_booking_app/features/home/screens/home_screen.dart';
import 'package:hotel_booking_app/routes/anywhere_door.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = BlocProvider.of<AuthCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authCubit.clearSignUpValues();
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
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  ImagePath.signUpImg,
                ),
              ),
              Text(
                'Create Your Account',
                style: AppTextStyles.f28W700Black,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    CommonTextfeild(
                      controller: _authCubit.nameController,
                      hintText: "Enter your name",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length <= 3) {
                          return 'Name must be at least 3 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CommonTextfeild(
                      controller: _authCubit.emailController,
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
                        return current is SignUpObstructPassword;
                      },
                      builder: (context, state) {
                        return CommonTextfeild(
                          controller: _authCubit.passwordController,
                          hintText: "Enter your password",
                          prefixIcon: Icons.lock,
                          obsecureText: _authCubit.signUpObstructPassword,
                          onSuffixTap: () {
                            _authCubit.showHideSignUpPassword();
                          },
                          suffixIcon: !_authCubit.signUpObstructPassword
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
                        if (state is SignUpSuccess) {
                          AnywhereDoor.pushAndRemoveUntil(context,
                              className: const HomeScreen());
                        }
                      },
                      listenWhen: (previous, current) =>
                          current is SignUpSuccess,
                      buildWhen: (previous, current) {
                        return current is SignUpFailed ||
                            current is SignUpLoading ||
                            current is SignUpSuccess;
                      },
                      builder: (context, state) {
                        return _authCubit.signUpLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppButton(
                                onPressed: () async {
                                  final bool isValidate =
                                      _signUpFormKey.currentState!.validate();
                                  await _authCubit.signUp(
                                      isValidate: isValidate, context: context);
                                },
                                child: const Text(
                                  'Sign Up',
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
                            className: const LoginScreen());
                      },
                      child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: AppTextStyles.f14W400Black,
                              children: [
                            TextSpan(
                                text: "Login here.",
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
