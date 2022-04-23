import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String email;
  String password;
  String name;
  String telephone;
  DateTime birthDate;
  bool hasCarpoolService;
  String imageUrl;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.telephone,
    required this.birthDate,
    required this.hasCarpoolService,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
