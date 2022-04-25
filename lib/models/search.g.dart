// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Search _$SearchFromJson(Map<String, dynamic> json) => Search(
      placeFrom: json['placeFrom'] == null
          ? null
          : Place.fromJson(json['placeFrom'] as Map<String, dynamic>),
      placeTo: json['placeTo'] == null
          ? null
          : Place.fromJson(json['placeTo'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      minSeatingCapacity: json['minSeatingCapacity'] as int?,
      maxPrice: json['maxPrice'] as int?,
      driverName: json['driverName'] as String?,
      canTransportPets: json['canTransportPets'] as bool?,
      canTransportBicycle: json['canTransportBicycle'] as bool?,
      isGoingHighway: json['isGoingHighway'] as bool?,
    )..id = json['id'] as String;

Map<String, dynamic> _$SearchToJson(Search instance) => <String, dynamic>{
      'id': instance.id,
      'placeFrom': instance.placeFrom?.toJson(),
      'placeTo': instance.placeTo?.toJson(),
      'date': instance.date.toIso8601String(),
      'minSeatingCapacity': instance.minSeatingCapacity,
      'maxPrice': instance.maxPrice,
      'driverName': instance.driverName,
      'canTransportPets': instance.canTransportPets,
      'canTransportBicycle': instance.canTransportBicycle,
      'isGoingHighway': instance.isGoingHighway,
    };
