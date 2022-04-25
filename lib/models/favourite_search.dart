import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/search.dart';

import 'package:json_annotation/json_annotation.dart';

part 'favourite_search.g.dart';

@JsonSerializable(explicitToJson: true)
class FavouriteSearch extends Search {
  final String userId;

  FavouriteSearch({
    required this.userId,
    Place? placeFrom,
    Place? placeTo,
    required DateTime date,
    int? minSeatingCapacity,
    int? maxPrice,
    String? driverName,
    bool? canTransportPets,
    bool? canTransportBicycle,
    bool? isGoingHighway,
  }) : super(
          placeFrom: placeFrom,
          placeTo: placeTo,
          date: date,
          minSeatingCapacity: minSeatingCapacity,
          maxPrice: maxPrice,
          driverName: driverName,
          canTransportPets: canTransportPets,
          canTransportBicycle: canTransportBicycle,
          isGoingHighway: isGoingHighway,
        );

  factory FavouriteSearch.fromJson(Map<String, dynamic> json) =>
      _$FavouriteSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavouriteSearchToJson(this);

  factory FavouriteSearch.fromFireBase(Map<String, dynamic> json) {
    var search = _$FavouriteSearchFromJson(json);
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

  @override
  Map<String, dynamic> toFireBase() {
    var json = _$FavouriteSearchToJson(this);
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
