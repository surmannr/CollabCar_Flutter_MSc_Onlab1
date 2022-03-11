import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/search.dart';

import 'package:json_annotation/json_annotation.dart';

part 'favourite_search.g.dart';

@JsonSerializable()
class FavouriteSearch extends Search {
  final int id;
  final int userId;
  final int driverId;

  FavouriteSearch({
    required this.id,
    required this.userId,
    required this.driverId,
    required Place placeFrom,
    required Place placeTo,
    required DateTime date,
    required int minSeatingCapacity,
    required int maxPrice,
    required String driverName,
    required bool canTransportPets,
    required bool canTransportBicycle,
    required bool isGoingHighway,
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

  Map<String, dynamic> toJson() => _$FavouriteSearchToJson(this);
}
