// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceApplication _$ServiceApplicationFromJson(Map<String, dynamic> json) =>
    ServiceApplication(
      service: Service.fromJson(json['service'] as Map<String, dynamic>),
      isAccepted: json['isAccepted'] as bool,
      creatorUser: User.fromJson(json['creatorUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceApplicationToJson(ServiceApplication instance) =>
    <String, dynamic>{
      'service': instance.service.toJson(),
      'creatorUser': instance.creatorUser.toJson(),
      'isAccepted': instance.isAccepted,
    };
