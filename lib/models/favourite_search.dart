import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/search.dart';

import 'package:json_annotation/json_annotation.dart';

part 'favourite_search.g.dart';

@JsonSerializable()
class FavouriteSearch extends Search {
  final int userId;
  final int driverId;

  FavouriteSearch({
    required this.userId,
    required this.driverId,
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
}
