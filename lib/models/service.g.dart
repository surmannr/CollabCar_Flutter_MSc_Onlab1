// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      id: json['id'] as int,
      placeFrom: Place.fromJson(json['placeFrom'] as Map<String, dynamic>),
      placeTo: Place.fromJson(json['placeTo'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      price: json['price'] as int,
      canTransportPets: json['canTransportPets'] as bool,
      canTransportBicycle: json['canTransportBicycle'] as bool,
      isGoingHighway: json['isGoingHighway'] as bool,
      creatorUserId: json['creatorUserId'] as int,
      selectedCarId: json['selectedCarId'] as int,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'id': instance.id,
      'placeFrom': instance.placeFrom,
      'placeTo': instance.placeTo,
      'date': instance.date.toIso8601String(),
      'price': instance.price,
      'canTransportPets': instance.canTransportPets,
      'canTransportBicycle': instance.canTransportBicycle,
      'isGoingHighway': instance.isGoingHighway,
      'creatorUserId': instance.creatorUserId,
      'selectedCarId': instance.selectedCarId,
    };
