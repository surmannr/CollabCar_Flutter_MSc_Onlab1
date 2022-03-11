import 'package:json_annotation/json_annotation.dart';

import 'package:collabcar/models/place.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  Place? placeFrom;
  Place? placeTo;
  DateTime date = DateTime.now();
  int? minSeatingCapacity;
  int? maxPrice;
  String? driverName;
  bool? canTransportPets;
  bool? canTransportBicycle;
  bool? isGoingHighway;

  Search({
    this.placeFrom,
    this.placeTo,
    required this.date,
    this.minSeatingCapacity,
    this.maxPrice,
    this.driverName,
    this.canTransportPets,
    this.canTransportBicycle,
    this.isGoingHighway,
  });

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
