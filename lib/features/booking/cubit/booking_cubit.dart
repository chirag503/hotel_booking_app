import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking_app/features/booking/cubit/booking_state.dart';
import 'package:hotel_booking_app/features/home/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  List<BookingModel> _bookingList = [];
  List<BookingModel> get bookingList => _bookingList;

  // get hotel booking list
  Future<void> getBookingList() async {
    // Open Hive box
    await Hive.openBox<BookingModel>('booking');
    Box<BookingModel> bookingBox = Hive.box<BookingModel>('booking');
    try {
      _bookingList = [];
      emit(BookingListLoading());

      // Retrieve email
      final prefs = await SharedPreferences.getInstance();
      final emailId = prefs.getString("email");

      final List<BookingModel> list =
          bookingBox.values.toList().cast<BookingModel>();
      for (var element in list) {
        if (element.email == emailId) {
          _bookingList.add(element);
        }
      }
      emit(BookingListSuccess());
    } catch (e) {
      _bookingList = [];
      emit(BookingListFailed());
    } finally {
      bookingBox.close();
    }
  }
}
