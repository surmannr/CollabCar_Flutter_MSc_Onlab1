import 'package:collabcar/models/place.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'car.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  String id;
  late Place placeFrom;
  late Place placeTo;
  DateTime date;
  int price;
  bool canTransportPets;
  bool canTransportBicycle;
  bool isGoingHighway;
  String creatorUserId;
  Car selectedCar;

  Service({
    required this.placeFrom,
    required this.placeTo,
    required this.date,
    required this.price,
    required this.canTransportPets,
    required this.canTransportBicycle,
    required this.isGoingHighway,
    required this.creatorUserId,
    required this.selectedCar,
    var uuid = const Uuid(),
  }) : id = uuid.v1();

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  factory Service.fromFireBase(Map<String, dynamic> json) {
    var service = _$ServiceFromJson(json);
    if (json['placeTo.address'] != null) {
      service.placeTo = Place(
          latitude: (json['placeTo.latitude'] as num).toDouble(),
          longitude: (json['placeTo.longitude'] as num).toDouble(),
          address: json['placeTo.address'] as String);
    }
    if (json['placeFrom.address'] != null) {
      service.placeFrom = Place(
          latitude: (json['placeFrom.latitude'] as num).toDouble(),
          longitude: (json['placeFrom.longitude'] as num).toDouble(),
          address: json['placeFrom.address'] as String);
    }

    service.selectedCar = Car(
      id: (json['selectedCar.id'] as String),
      registrationNumber: (json['selectedCar.registrationNumber'] as String),
      year: (json['selectedCar.year'] as num).toInt(),
      type: (json['selectedCar.type'] as String),
      technicalInspectionExpirationDate: DateTime.parse(
          json['selectedCar.technicalInspectionExpirationDate'] as String),
      seatingCapacity: (json['selectedCar.seatingCapacity'] as num).toInt(),
      trunkCapacity: (json['selectedCar.trunkCapacity'] as num).toInt(),
      imageUrl: (json['selectedCar.imageUrl'] as String),
      userId: (json['selectedCar.userId'] as String),
    );

    return service;
  }

  Map<String, dynamic> toFireBase() {
    var json = _$ServiceToJson(this);
    json.remove('placeFrom');
    json.remove('placeTo');
    json.remove('selectedCar');
    json.addAll({
      'placeFrom.longitude': placeFrom.longitude,
      'placeFrom.latitude': placeFrom.latitude,
      'placeFrom.address': placeFrom.address,
      'placeTo.longitude': placeTo.longitude,
      'placeTo.latitude': placeTo.latitude,
      'placeTo.address': placeTo.address,
      'selectedCar.id': selectedCar.id,
      'selectedCar.registrationNumber': selectedCar.registrationNumber,
      'selectedCar.year': selectedCar.year,
      'selectedCar.type': selectedCar.type,
      'selectedCar.imageUrl': selectedCar.imageUrl,
      'selectedCar.userId': selectedCar.userId,
      'selectedCar.trunkCapacity': selectedCar.trunkCapacity,
      'selectedCar.seatingCapacity': selectedCar.seatingCapacity,
      'selectedCar.technicalInspectionExpirationDate':
          selectedCar.technicalInspectionExpirationDate,
    });
    return json;
  }
}
