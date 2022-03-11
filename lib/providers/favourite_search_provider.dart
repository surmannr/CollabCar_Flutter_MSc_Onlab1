import 'package:collabcar/models/favourite_search.dart';
import 'package:collabcar/models/place.dart';
import 'package:flutter/material.dart';

import '../models/search.dart';

class FavouriteSearchProvider with ChangeNotifier {
  List<FavouriteSearch> _favourites = [
    FavouriteSearch(
      date: DateTime.now(),
      placeFrom: Place(address: "asd", latitude: 2.0, longitude: 1.0),
      userId: 2,
      placeTo: Place(address: "asd", latitude: 2.0, longitude: 1.0),
      maxPrice: 3000,
      minSeatingCapacity: 3,
      driverId: 2,
      driverName: "rudii",
      canTransportBicycle: true,
      canTransportPets: false,
      isGoingHighway: true,
    ),
  ];

  List<FavouriteSearch> get favourites {
    return _favourites;
  }

  Future<List<FavouriteSearch>> getFromFirebase() async {
    return _favourites;
  }

  void addNewFavouriteElement(FavouriteSearch search) async {
    _favourites.add(search);

    notifyListeners();
  }

  void deleteFavouriteElement(String id) async {
    _favourites.removeWhere((element) => element.id == id);

    notifyListeners();
  }
}
