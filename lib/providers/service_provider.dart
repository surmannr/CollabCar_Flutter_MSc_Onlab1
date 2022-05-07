import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/search.dart';
import 'package:collabcar/models/service_application.dart';
import 'package:collabcar/models/user.dart';
import 'package:flutter/material.dart';

import 'package:collabcar/models/service.dart';

class ServiceProvider with ChangeNotifier {
  final CollectionReference _services = FirebaseFirestore.instance
      .collection('service')
      .withConverter<Service>(
          fromFirestore: (snapshot, _) => Service.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Stream<QuerySnapshot> getFromFirebase() {
    return _services.snapshots();
  }

  Stream<QuerySnapshot> getFromFirebaseByLoggedUser(String userId) {
    return _services.where('creatorUser.id', isEqualTo: userId).snapshots();
  }

  Stream<QuerySnapshot> servicesFilteredBySearch(Search search) {
    return _services.filterServices(search).snapshots();
  }

  Future<List<Passenger>> getPassengersForService(String serviceId) async {
    var passengerDocs =
        await _services.doc(serviceId).collection("passenger").get();
    return passengerDocs.size != 0
        ? passengerDocs.docs.map((e) => Passenger.fromJson(e.data())).toList()
        : [];
  }

  void addNewServiceElement(Service service) async {
    service.id = "-";

    await _services.add(service).then((value) async {
      service.id = value.id;
      await _services.doc(service.id).update(service.toJson());
    });

    notifyListeners();
  }

  void deleteServiceElement(String id) async {
    var passengers = await _services.doc(id).collection("passenger").get();
    var passenger = Passenger.fromJson(passengers.docs.first.data());
    var serviceApplication = await FirebaseFirestore.instance
        .collection('users')
        .doc(passenger.user.id)
        .collection('reservations')
        .where('serviceId', isEqualTo: id)
        .get();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(passenger.user.id)
        .collection('reservations')
        .doc(serviceApplication.docs.first.id)
        .delete();

    await _services.doc(id).delete();

    notifyListeners();
  }

  void updateAcceptPassenger(
      String serviceId, String userId, String passengerId) async {
    await _services
        .doc(serviceId)
        .collection("passenger")
        .doc(passengerId)
        .update({"isAccepted": true});

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('reservations')
        .doc(passengerId)
        .update({"isAccepted": true});

    notifyListeners();
  }

  void addNewPassenger(Service service, User user) async {
    Passenger newPassenger = Passenger(
      id: "",
      service: service,
      user: user,
      isAccepted: false,
    );

    var addedPassenger = await _services
        .doc(service.id)
        .collection("passenger")
        .add(newPassenger.toJson());

    await _services
        .doc(service.id)
        .collection("passenger")
        .doc(addedPassenger.id)
        .update({'id': addedPassenger.id});

    ServiceApplication newServiceApplication = ServiceApplication(
      service: service,
      isAccepted: false,
      creatorUser: service.creatorUser,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection('reservations')
        .doc(addedPassenger.id)
        .set(newServiceApplication.toJson());

    notifyListeners();
  }
}

extension ServiceFilter on CollectionReference {
  Query<Object?> filterServices(Search search) {
    Query<Object?> query = orderBy('date');

    if (search.maxPrice != null) {
      query.where('price', isLessThanOrEqualTo: search.maxPrice);
    }

    if (search.isGoingHighway != null) {
      query.where('isGoingHighway', isEqualTo: search.isGoingHighway);
    }

    if (search.canTransportBicycle != null) {
      query.where('canTransportBicycle', isEqualTo: search.canTransportBicycle);
    }

    if (search.canTransportPets != null) {
      query.where('canTransportPets', isEqualTo: search.canTransportPets);
    }

    return query;
  }
}
