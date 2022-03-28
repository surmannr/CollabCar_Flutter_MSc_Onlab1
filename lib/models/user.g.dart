// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      telephone: json['telephone'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      hasCarpoolService: json['hasCarpoolService'] as bool,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'telephone': instance.telephone,
      'birthDate': instance.birthDate.toIso8601String(),
      'hasCarpoolService': instance.hasCarpoolService,
      'imageUrl': instance.imageUrl,
    };
