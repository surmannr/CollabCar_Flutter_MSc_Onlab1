import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/search.dart';
import 'package:flutter/material.dart';

import 'package:collabcar/models/service.dart';

class ServiceProvider with ChangeNotifier {
  final CollectionReference _services = FirebaseFirestore.instance
      .collection('service')
      .withConverter<Service>(
          fromFirestore: (snapshot, _) =>
              Service.fromFireBase(snapshot.data()!),
          toFirestore: (model, _) => model.toFireBase());

  Stream<QuerySnapshot> getFromFirebase() {
    return _services.snapshots();
  }

  Stream<QuerySnapshot> getFromFirebaseByLoggedUser(String userId) {
    return _services.where('creatorUserId', isEqualTo: userId).snapshots();
  }

  Stream<QuerySnapshot> servicesFilteredBySearch(Search search) {
    return _services.filterServices(search).snapshots();
  }

  void addNewServiceElement(Service service) async {
    _services.add(service);

    notifyListeners();
  }

  void deleteFavouriteElement(String id) async {
    await _services.doc(id).delete();

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
