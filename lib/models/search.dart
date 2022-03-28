import 'package:json_annotation/json_annotation.dart';

import 'package:collabcar/models/place.dart';
import 'package:uuid/uuid.dart';

part 'search.g.dart';

@JsonSerializable()
class Search {
  String id;
  Place? placeFrom;
  Place? placeTo;
  DateTime date = DateTime.now();
  int? minSeatingCapacity;
  int? maxPrice;
  String? driverName;
  bool? canTransportPets;
  bool? canTransportBicycle;
  bool? isGoingHighway;

  Search(
      {this.placeFrom,
      this.placeTo,
      required this.date,
      this.minSeatingCapacity,
      this.maxPrice,
      this.driverName,
      this.canTransportPets,
      this.canTransportBicycle,
      this.isGoingHighway,
      var uuid = const Uuid()})
      : id = uuid.v1();

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);

  factory Search.fromFireBase(Map<String, dynamic> json) {
    var search = _$SearchFromJson(json);
    if (json['placeTo.address'] != null) {
      search.placeTo = Place(
          latitude: (json['placeTo.latitude'] as num).toDouble(),
          longitude: (json['placeTo.longitude'] as num).toDouble(),
          address: json['placeTo.address'] as String);
    }
    if (json['placeFrom.address'] != null) {
      search.placeFrom = Place(
          latitude: (json['placeFrom.latitude'] as num).toDouble(),
          longitude: (json['placeFrom.longitude'] as num).toDouble(),
          address: json['placeFrom.address'] as String);
    }
    return search;
  }

  Map<String, dynamic> toFireBase() {
    var json = _$SearchToJson(this);
    json.remove('placeFrom');
    json.remove('placeTo');
    json.addAll({
      'placeFrom.longitude': placeFrom?.longitude,
      'placeFrom.latitude': placeFrom?.latitude,
      'placeFrom.address': placeFrom?.address,
      'placeTo.longitude': placeTo?.longitude,
      'placeTo.latitude': placeTo?.latitude,
      'placeTo.address': placeTo?.address,
    });
    return json;
  }
}
