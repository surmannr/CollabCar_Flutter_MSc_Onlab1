// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: json['id'] as int,
      registrationNumber: json['registrationNumber'] as String,
      year: json['year'] as int,
      type: json['type'] as String,
      technicalInspectionExpirationDate:
          DateTime.parse(json['technicalInspectionExpirationDate'] as String),
      seatingCapacity: json['seatingCapacity'] as int,
      trunkCapacity: json['trunkCapacity'] as int,
      imageUrl: json['imageUrl'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'registrationNumber': instance.registrationNumber,
      'year': instance.year,
      'type': instance.type,
      'technicalInspectionExpirationDate':
          instance.technicalInspectionExpirationDate.toIso8601String(),
      'seatingCapacity': instance.seatingCapacity,
      'trunkCapacity': instance.trunkCapacity,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
    };
