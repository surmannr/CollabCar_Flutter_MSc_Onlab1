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
    return _services.snapshots(); //filterServices(search).snapshots();
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
        .collection('serviceApplications')
        .where('serviceId', isEqualTo: id)
        .get();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(passenger.user.id)
        .collection('serviceApplications')
        .doc(serviceApplication.docs.first.id)
        .delete();

    await _services.doc(id).delete();

    notifyListeners();
  }

  void addNewPassenger(Service service, User user) async {
    Passenger newPassenger = Passenger(
      service: service,
      user: user,
      isAccepted: false,
    );

    await _services
        .doc(service.id)
        .collection("passenger")
        .add(newPassenger.toJson());

    ServiceApplication newServiceApplication = ServiceApplication(
      service: service,
      isAccepted: false,
      creatorUser: service.creatorUser,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection('serviceApplications')
        .add(newServiceApplication.toJson());

    notifyListeners();
  }
}

extension ServiceFilter on CollectionReference {
  Query<Object?> filterServices(Search search) {
    Query<Object?> query = orderBy('date');
    if (search.placeTo != null) {
      if (search.placeTo!.address.isNotEmpty) {
        query.where('placeTo.address',
            arrayContains: search.placeTo!.address.split(' '));
      }
    }

    if (search.placeFrom != null) {
      if (search.placeFrom!.address.isNotEmpty) {
        query.where('placeFrom.address',
            arrayContains: search.placeFrom!.address.split(' '));
      }
    }

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
