// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      id: json['id'] as String,
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      isAccepted: json['isAccepted'] as bool,
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) => <String, dynamic>{
      'id': instance.id,
      'service': instance.service.toJson(),
      'user': instance.user.toJson(),
      'isAccepted': instance.isAccepted,
    };
