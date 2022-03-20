import 'package:collabcar/models/favourite_search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteSearchProvider with ChangeNotifier {
  final CollectionReference _favouriteSearch = FirebaseFirestore.instance
      .collection('favourite_search')
      .withConverter<FavouriteSearch>(
          fromFirestore: (snapshot, _) =>
              FavouriteSearch.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Stream<QuerySnapshot> getFromFirebase() {
    return _favouriteSearch.snapshots();
  }

  void addNewFavouriteElement(FavouriteSearch search) async {
    await _favouriteSearch.add(search);

    notifyListeners();
  }

  void deleteFavouriteElement(String id) async {
    await _favouriteSearch.doc(id).delete();

    notifyListeners();
  }
}
