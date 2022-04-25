import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable(explicitToJson: true)
class Car {
  String id;
  String registrationNumber;
  int year;
  String type;
  DateTime technicalInspectionExpirationDate;
  int seatingCapacity;
  int trunkCapacity;
  String imageUrl;
  String userId;

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
