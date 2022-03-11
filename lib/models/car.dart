import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
  final int id;
  final String registrationNumber;
  final int year;
  final String type;
  final DateTime technicalInspectionExpirationDate;
  final int seatingCapacity;
  final int trunkCapacity;
  final String imageUrl;
  final int userId;

  Car({
    required this.id,
    required this.registrationNumber,
    required this.year,
    required this.type,
    required this.technicalInspectionExpirationDate,
    required this.seatingCapacity,
    required this.trunkCapacity,
    required this.imageUrl,
    required this.userId,
  });

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  Map<String, dynamic> toJson() => _$CarToJson(this);
}
