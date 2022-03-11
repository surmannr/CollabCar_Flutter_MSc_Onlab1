import 'package:collabcar/models/place.dart';

import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  final int id;
  final Place placeFrom;
  final Place placeTo;
  final DateTime date;
  final int price;
  final bool canTransportPets;
  final bool canTransportBicycle;
  final bool isGoingHighway;
  final int creatorUserId;
  final int selectedCarId;

  Service({
    required this.id,
    required this.placeFrom,
    required this.placeTo,
    required this.date,
    required this.price,
    required this.canTransportPets,
    required this.canTransportBicycle,
    required this.isGoingHighway,
    required this.creatorUserId,
    required this.selectedCarId,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
