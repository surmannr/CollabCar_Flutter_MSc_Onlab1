import 'package:collabcar/models/car.dart';
import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/search.dart';
import 'package:flutter/material.dart';

import 'package:collabcar/models/service.dart';

class ServiceProvider with ChangeNotifier {
  static Car tempCar = Car(
      id: 1,
      registrationNumber: "200412",
      year: 2005,
      type: "Ford",
      technicalInspectionExpirationDate: DateTime(2026),
      seatingCapacity: 4,
      trunkCapacity: 3,
      imageUrl: "majd lesz",
      userId: 2);

  final List<Service> _services = [
    Service(
      placeFrom: Place(latitude: 0, longitude: 0, address: "Sorompó"),
      placeTo: Place(latitude: 0, longitude: 0, address: "Áruház"),
      date: DateTime.now().add(const Duration(days: 3)),
      price: 10000,
      canTransportPets: true,
      canTransportBicycle: false,
      isGoingHighway: false,
      creatorUserId: 2,
      selectedCar: tempCar,
    ),
    Service(
      placeFrom: Place(latitude: 0, longitude: 0, address: "Micsoda"),
      placeTo: Place(latitude: 0, longitude: 0, address: "Jó ez"),
      date: DateTime.now().add(const Duration(days: 2)),
      price: 1300,
      canTransportPets: false,
      canTransportBicycle: false,
      isGoingHighway: true,
      creatorUserId: 1,
      selectedCar: tempCar,
    ),
    Service(
      placeFrom: Place(latitude: 0, longitude: 0, address: "Leves"),
      placeTo: Place(latitude: 0, longitude: 0, address: "Föld"),
      date: DateTime.now().add(const Duration(days: 12)),
      price: 5000,
      canTransportPets: true,
      canTransportBicycle: true,
      isGoingHighway: true,
      creatorUserId: 2,
      selectedCar: tempCar,
    ),
    Service(
      placeFrom: Place(latitude: 0, longitude: 0, address: "Létra"),
      placeTo: Place(latitude: 0, longitude: 0, address: "Dinó"),
      date: DateTime.now().add(const Duration(days: 12)),
      price: 5000,
      canTransportPets: true,
      canTransportBicycle: true,
      isGoingHighway: true,
      creatorUserId: 1,
      selectedCar: tempCar,
    ),
  ];

  List<Service> get services => _services;

  List<Service> get servicesByLoggedUser {
    return _services
        .where((element) => element.creatorUserId == 2 /* TODO */)
        .toList();
  }

  Future<List<Service>> servicesFilteredBySearch(Search search) async {
    _filterServices(search);
    return services;
  }

  Future<List<Service>> getFromFirebase() async {
    return _services;
  }

  void addNewServiceElement(Service service) async {
    _services.add(service);

    notifyListeners();
  }

  void deleteFavouriteElement(String id) async {
    _services.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void _filterServices(Search search) {
    if (search.placeTo != null) {
      if (search.placeTo!.address.isNotEmpty) {
        _services.retainWhere((element) =>
            element.placeTo.address.contains(search.placeTo!.address));
      }
    }

    if (search.placeFrom != null) {
      if (search.placeFrom!.address.isNotEmpty) {
        _services.retainWhere((element) =>
            element.placeFrom.address.contains(search.placeFrom!.address));
      }
    }

    if (search.maxPrice != null) {
      _services.retainWhere((element) => element.price <= search.maxPrice!);
    }

    if (search.isGoingHighway != null) {
      _services.retainWhere(
          (element) => element.isGoingHighway == search.isGoingHighway);
    }

    if (search.canTransportBicycle != null) {
      _services.retainWhere((element) =>
          element.canTransportBicycle == search.canTransportBicycle);
    }

    if (search.canTransportPets != null) {
      _services.retainWhere(
          (element) => element.canTransportPets == search.canTransportPets);
    }
  }
}
