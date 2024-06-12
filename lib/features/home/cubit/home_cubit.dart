import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hotel_booking_app/features/home/cubit/home_state.dart';
import 'package:hotel_booking_app/features/home/models/booking_model.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
import 'package:hotel_booking_app/utils/helper_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<HotelItem> _hotelsList = [];
  List<HotelItem> get hotelsList => _hotelsList;

  // ignore: prefer_final_fields
  List<HotelItem> _hotelsSearchList = [];
  List<HotelItem> get hotelsSearchList => _hotelsSearchList;

  Timer? _debounce;

  bool _isSearchMode = false;
  bool get isSearchMode => _isSearchMode;

// Get Hotel Data List from json file
  Future<void> getHotelsData() async {
    _hotelsList.clear();
    emit(HotelDataLoading());
    try {
      final data = await rootBundle.loadString("assets/jsons/hotel.json");
      final jsonData = jsonDecode(data);
      final result = HotelDataModel.fromJson(jsonData);
      _hotelsList = result.data ?? [];

      emit(HotelDataSuccess());
    } catch (e) {
      _hotelsList.clear();
      emit(HotelDataFailed());
    }
  }

// Search Hotel based on city
  void searchHotels(String query) {
    if (query.isEmpty) {
      _isSearchMode = false;
      _hotelsSearchList.clear();
      emit(SearchHotelDataSuccess());
    } else {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        if (!_isSearchMode) {
          _isSearchMode = true;
        }
        emit(SearchHotelDataLoading());
        _hotelsSearchList.clear();
        try {
          for (var element in _hotelsList) {
            if ((element.city ?? "")
                .toLowerCase()
                .contains(query.toLowerCase())||(element.hotelName ?? "")
                .toLowerCase()
                .contains(query.toLowerCase())) {
              _hotelsSearchList.add(element);
            }
          }

          emit(SearchHotelDataSuccess());
        } catch (e) {
          emit(SearchHotelDataFailed());
        }
      });
    }
  }

// <===========================Detail Screen variables and functions=============================>

  DateTimeRange? _checkInOutDate;
  DateTimeRange? get checkInOutDate => _checkInOutDate;

  int _peopleCount = 1;
  int get peopleCount => _peopleCount;

  void clearValues() {
    _peopleCount = 1;
    _checkInOutDate = null;
    emit(ClearIntialValues());
  }

// select check in and check out date
  Future<void> checkInOutDatePick({required BuildContext context}) async {
    _checkInOutDate = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    emit(CheckInOutDateSuccess());
  }

// increment number of people
  void incrementPeopleCount() {
    _peopleCount++;
    emit(IncrementPeopleCount());
  }

// decrement number of people
  void decrementPeopleCount() {
    if (_peopleCount > 0) {
      _peopleCount--;
      emit(DecrementPeopleCount());
    } else {
      HelperMethods.showToast("Minimum 1 person required", bgColor: Colors.red);
    }
  }

// Book Hotel
  Future<void> bookHotel(HotelItem data) async {
    // Open Hive box
    await Hive.openBox<BookingModel>('booking');
    Box<BookingModel> bookingBox = Hive.box<BookingModel>('booking');
    try {
      if (_checkInOutDate?.start == null || _checkInOutDate?.end == null) {
        HelperMethods.showToast("Please select check in and out date",
            bgColor: Colors.red);
      } else if (_peopleCount <= 0) {
        HelperMethods.showToast("Please select number of people",
            bgColor: Colors.red);
      } else {
        // Retrieve current items or initialize an empty list
        final List<BookingModel> currentItems =
            bookingBox.values.toList().cast<BookingModel>();

        // Retrieve email
        final prefs = await SharedPreferences.getInstance();
        final emailId = prefs.getString("email");
        // Add new booking
        currentItems.add(BookingModel(
            hotelData: data,
            startDate: _checkInOutDate!.start,
            endDate: _checkInOutDate!.end,
            totalPerson: _peopleCount,
            email: emailId ?? ""));
        // Clear and update the Hive box
        await bookingBox.clear();
        await bookingBox.addAll(currentItems);
        HelperMethods.showToast("Successfully booked", bgColor: Colors.green);
      }
    } catch (e) {
      HelperMethods.showToast("Something went wrong", bgColor: Colors.red);
    } finally {
      await bookingBox.close();
    }
  }
}
