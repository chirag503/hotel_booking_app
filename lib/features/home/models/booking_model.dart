import 'package:hive/hive.dart';
import 'package:hotel_booking_app/features/home/models/hotel_data_model.dart';
part 'booking_model.g.dart';

@HiveType(typeId: 2)
class BookingModel extends HiveObject {
  @HiveField(0)
  final HotelItem hotelData;

  @HiveField(1)
  final DateTime startDate;

  @HiveField(2)
  final DateTime endDate;

  @HiveField(3)
  final int totalPerson;

  @HiveField(4)
  final String email;

  BookingModel({
    required this.hotelData,
    required this.totalPerson,
    required this.startDate,
    required this.endDate,
    required this.email,
  });
}
