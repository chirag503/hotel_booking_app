import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelperMethods {
  // Show Toast
  static void showToast(String message, {Color? bgColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor ?? Colors.black54,
      textColor: Colors.white,
    );
  }

//get Amenity Icon
  static IconData getAmenitiesIcon(String val) {
    switch (val) {
      case "wifi":
        return Icons.wifi;
      case "laundry":
        return Icons.local_laundry_service;
      case "room_service":
        return Icons.room_service;
      case "parking":
        return Icons.local_parking;
      case "pool":
        return Icons.pool;
      case "restaurant":
        return Icons.restaurant;
      case "bar":
        return Icons.local_drink;
      case "security":
        return Icons.security;
      case "housekeeping":
        return Icons.person;
      default:
        return Icons.person;
    }
  }

  //get Amenity String
  static String getAmenitiesString(String val) {
    switch (val) {
      case "wifi":
        return "Wifi";
      case "laundry":
        return "Laundry";
      case "room_service":
        return "Room Service";
      case "parking":
        return "Parking";
      case "pool":
        return "Pool";
      case "restaurant":
        return "Restaurant";
      case "bar":
        return "Bar";
      case "security":
        return "Security";
      case "housekeeping":
        return "Housekeeping";
      default:
        return "";
    }
  }

//get Room type String
  static String getRoomTypesString(String val) {
    switch (val) {
      case "single":
        return "Single";
      case "double":
        return "Double";
      case "hostel":
        return "Hostel";
      case "deluxe":
        return "Deluxe";

      default:
        return "";
    }
  }

//get Room type Icon
  static IconData getRoomTypeIcon(String val) {
    switch (val) {
      case "single":
        return Icons.single_bed;
      case "double":
        return Icons.bed;
      case "hostel":
        return Icons.hotel;
      case "deluxe":
        return Icons.house;
      default:
        return Icons.person;
    }
  }
}
