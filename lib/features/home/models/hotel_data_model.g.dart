// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelItemAdapter extends TypeAdapter<HotelItem> {
  @override
  final int typeId = 1;

  @override
  HotelItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotelItem(
      hotelId: fields[1] as num?,
      hotelName: fields[2] as String?,
      addressline1: fields[3] as String?,
      amenities: (fields[4] as List?)?.cast<String>(),
      roomType: (fields[5] as List?)?.cast<String>(),
      city: fields[6] as String?,
      state: fields[7] as String?,
      country: fields[8] as String?,
      starRating: fields[9] as num?,
      url: fields[10] as String?,
      photo: fields[11] as String?,
      photoList: (fields[12] as List?)?.cast<String>(),
      overview: fields[13] as String?,
      ratesFrom: fields[14] as num?,
      numberOfReviews: fields[15] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, HotelItem obj) {
    writer
      ..writeByte(15)
      ..writeByte(1)
      ..write(obj.hotelId)
      ..writeByte(2)
      ..write(obj.hotelName)
      ..writeByte(3)
      ..write(obj.addressline1)
      ..writeByte(4)
      ..write(obj.amenities)
      ..writeByte(5)
      ..write(obj.roomType)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.state)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.starRating)
      ..writeByte(10)
      ..write(obj.url)
      ..writeByte(11)
      ..write(obj.photo)
      ..writeByte(12)
      ..write(obj.photoList)
      ..writeByte(13)
      ..write(obj.overview)
      ..writeByte(14)
      ..write(obj.ratesFrom)
      ..writeByte(15)
      ..write(obj.numberOfReviews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
