import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/user.dart';

import 'package:json_annotation/json_annotation.dart';

import 'car.dart';

part 'service.g.dart';

@JsonSerializable(explicitToJson: true)
class Service {
  late String id;
  late Place placeFrom;
  late Place placeTo;
  late DateTime date;
  late int price;
  late bool canTransportPets;
  late bool canTransportBicycle;
  late bool isGoingHighway;
  late User creatorUser;
  late Car selectedCar;

  Service({
    required this.placeFrom,
    required this.placeTo,
    required this.date,
    required this.price,
    required this.canTransportPets,
    required this.canTransportBicycle,
    required this.isGoingHighway,
    required this.creatorUser,
    required this.selectedCar,
  });

  Service.empty();

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
