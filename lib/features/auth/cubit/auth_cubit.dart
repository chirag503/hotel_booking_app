import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking_app/features/auth/cubit/auth_state.dart';
import 'package:hotel_booking_app/features/auth/models/user_model.dart';
import 'package:hotel_booking_app/utils/helper_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

// <======================== Login Screen Variable =========================>

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loginObstructPassword = true;
  bool get loginObstructPassword => _loginObstructPassword;

// clearing values login screen controllers
  void clearLoginValues() {
    emailLoginController.clear();
    passwordLoginController.clear();
  }

//  show and Hide password of Login password
  void showHideLoginPassword() {
    _loginObstructPassword = !_loginObstructPassword;
    emit(LoginObstructPassword());
  }

// Login user
  Future<void> login(
      {required bool isValidate, required BuildContext context}) async {
    if (isValidate) {
      _isLoading = true;
      emit(LoginLoading());
      await Hive.openBox<UserModel>('users');
      Box<UserModel> userBox = Hive.box<UserModel>('users');
      UserModel? userModel = userBox.get(emailLoginController.text.trim());
      if (userModel != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', userModel.email);
        _isLoading = false;
        emit(LoginSuccess());
        HelperMethods.showToast("Login Successful", bgColor: Colors.green);
        userBox.close();
      } else {
        _isLoading = false;
        emit(LoginFailed());
        HelperMethods.showToast("Please enter valid credentials",
            bgColor: Colors.red);
      }
    }
  }

  // <======================== Sign Up Screen Variable =========================>

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  bool _signUpObstructPassword = true;
  bool get signUpObstructPassword => _signUpObstructPassword;

// clearing values sign up screen controllers
  void clearSignUpValues() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

//  show and Hide password of Sign Up password
  void showHideSignUpPassword() {
    _signUpObstructPassword = !_signUpObstructPassword;
    emit(SignUpObstructPassword());
  }

// Sign Up User
  Future<void> signUp(
      {required bool isValidate, required BuildContext context}) async {
    if (isValidate) {
      try {
        _signUpLoading = true;
        emit(SignUpLoading());
        await Hive.openBox<UserModel>('users'); //open Hive box
        Box<UserModel> userBox = Hive.box<UserModel>('users');

        // check if user already exists based on email
        UserModel? userModel = userBox.get(emailController.text.trim());

        // Already exists show toast
        if (userModel != null) {
          _signUpLoading = false;
          emit(SignUpFailed());
          HelperMethods.showToast("User already exists. Please login",
              bgColor: Colors.red);
        }
        // otherwise create new user
        else {
          final user = UserModel(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          userBox.put(emailController.text.trim(), user);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', user.email);
          userBox.close();
          _signUpLoading = false;
          emit(SignUpSuccess());
          HelperMethods.showToast("Sign Up Successful", bgColor: Colors.green);
        }
      } catch (e) {
        _signUpLoading = false;
        emit(SignUpFailed());
        HelperMethods.showToast("Something went wrong. $e",
            bgColor: Colors.red);
      }
    }
  }
}
