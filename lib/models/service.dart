import 'package:collabcar/models/place.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'car.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  String id;
  final Place placeFrom;
  final Place placeTo;
  final DateTime date;
  final int price;
  final bool canTransportPets;
  final bool canTransportBicycle;
  final bool isGoingHighway;
  final int creatorUserId;
  final Car selectedCar;

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
}
