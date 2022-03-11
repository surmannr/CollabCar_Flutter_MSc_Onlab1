// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      serviceId: json['serviceId'] as int,
      userId: json['userId'] as int,
      isAccepted: json['isAccepted'] as bool,
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) => <String, dynamic>{
      'serviceId': instance.serviceId,
      'userId': instance.userId,
      'isAccepted': instance.isAccepted,
    };
