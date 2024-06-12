// To parse this JSON data, do
//
//     final hotelDataModel = hotelDataModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'hotel_data_model.g.dart';

HotelDataModel hotelDataModelFromJson(String str) =>
    HotelDataModel.fromJson(json.decode(str));

String hotelDataModelToJson(HotelDataModel data) => json.encode(data.toJson());

class HotelDataModel {
  final List<HotelItem>? data;

  HotelDataModel({
    this.data,
  });

  factory HotelDataModel.fromJson(Map<String, dynamic> json) => HotelDataModel(
        data: json["data"] == null
            ? []
            : List<HotelItem>.from(
                json["data"]!.map((x) => HotelItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 1)
class HotelItem {
  @HiveField(1)
  final num? hotelId;
  @HiveField(2)
  final String? hotelName;
  @HiveField(3)
  final String? addressline1;
  @HiveField(4)
  final List<String>? amenities;
  @HiveField(5)
  final List<String>? roomType;
  @HiveField(6)
  final String? city;
  @HiveField(7)
  final String? state;
  @HiveField(8)
  final String? country;
  @HiveField(9)
  final num? starRating;
  @HiveField(10)
  final String? url;
  @HiveField(11)
  final String? photo;
  @HiveField(12)
  final List<String>? photoList;
  @HiveField(13)
  final String? overview;
  @HiveField(14)
  final num? ratesFrom;
  @HiveField(15)
  final num? numberOfReviews;

  HotelItem({
    this.hotelId,
    this.hotelName,
    this.addressline1,
    this.amenities,
    this.roomType,
    this.city,
    this.state,
    this.country,
    this.starRating,
    this.url,
    this.photo,
    this.photoList,
    this.overview,
    this.ratesFrom,
    this.numberOfReviews,
  });

  factory HotelItem.fromJson(Map<String, dynamic> json) => HotelItem(
        hotelId: json["hotel_id"],
        hotelName: json["hotel_name"],
        addressline1: json["addressline1"],
        amenities: json["amenities"] == null
            ? []
            : List<String>.from(json["amenities"]!.map((x) => x)),
        roomType: json["room_type"] == null
            ? []
            : List<String>.from(json["room_type"]!.map((x) => x)),
        city: json["city"],
        state: json["state"],
        country: json["country"],
        starRating: json["star_rating"],
        url: json["url"],
        photo: json["photo"],
        photoList: json["photoList"] == null
            ? []
            : List<String>.from(json["photoList"]!.map((x) => x)),
        overview: json["overview"],
        ratesFrom: json["rates_from"],
        numberOfReviews: json["number_of_reviews"],
      );

  Map<String, dynamic> toJson() => {
        "hotel_id": hotelId,
        "hotel_name": hotelName,
        "addressline1": addressline1,
        "amenities": amenities == null
            ? []
            : List<dynamic>.from(amenities!.map((x) => x)),
        "room_type":
            roomType == null ? [] : List<dynamic>.from(roomType!.map((x) => x)),
        "city": city,
        "state": state,
        "country": country,
        "star_rating": starRating,
        "url": url,
        "photo": photo,
        "photoList": photoList == null
            ? []
            : List<dynamic>.from(photoList!.map((x) => x)),
        "overview": overview,
        "rates_from": ratesFrom,
        "number_of_reviews": numberOfReviews,
      };
}
