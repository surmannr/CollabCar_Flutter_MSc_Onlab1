// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      placeFrom: Place.fromJson(json['placeFrom'] as Map<String, dynamic>),
      placeTo: Place.fromJson(json['placeTo'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      price: json['price'] as int,
      canTransportPets: json['canTransportPets'] as bool,
      canTransportBicycle: json['canTransportBicycle'] as bool,
      isGoingHighway: json['isGoingHighway'] as bool,
      creatorUser: User.fromJson(json['creatorUser'] as Map<String, dynamic>),
      selectedCar: Car.fromJson(json['selectedCar'] as Map<String, dynamic>),
    )..id = json['id'] as String;

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'placeFrom': instance.placeFrom.toJson(),
      'placeTo': instance.placeTo.toJson(),
      'date': instance.date.toIso8601String(),
      'price': instance.price,
      'canTransportPets': instance.canTransportPets,
      'canTransportBicycle': instance.canTransportBicycle,
      'isGoingHighway': instance.isGoingHighway,
      'creatorUser': instance.creatorUser.toJson(),
      'selectedCar': instance.selectedCar.toJson(),
    };
