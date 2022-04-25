import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/car.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collabcar/models/user.dart' as my_user;

class LoggedUserProvider with ChangeNotifier {
  my_user.User? user;
  List<Car> cars = [];

  late CollectionReference carsCollection;
  var users = FirebaseFirestore.instance
      .collection('users')
      .withConverter<my_user.User>(
          fromFirestore: (snapshot, _) =>
              my_user.User.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  Future<void> login(User fireBaseUser) async {
    var docUser = await users.doc(fireBaseUser.uid).get();
    carsCollection = users
        .doc(fireBaseUser.uid)
        .collection('car')
        .withConverter<Car>(
            fromFirestore: (snapshot, _) => Car.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson());

    user = docUser.data();
    QuerySnapshot carQuerySnapshot = await carsCollection.get();
    cars = carQuerySnapshot.docs.map((doc) => doc.data() as Car).toList();
  }

  Stream<QuerySnapshot> getLoggedUserReservations() {
    return users.doc(user!.id).collection("reservations").snapshots();
  }

  Future<void> modifyUser(my_user.User user) async {
    await users.doc(user.id).update(user.toJson());
  }

  Future<void> createOrModifyUserCar(Car car) async {
    if (car.id.isEmpty) {
      car.userId = user!.id;
      await users
          .doc(user!.id)
          .collection('car')
          .add(car.toJson())
          .then((value) async {
        car.id = value.id;
        await users
            .doc(user!.id)
            .collection('car')
            .doc(car.id)
            .update(car.toJson());
      });
    } else {
      await users
          .doc(user!.id)
          .collection('car')
          .doc(car.id)
          .update(car.toJson());
    }
    notifyListeners();
  }

  Future<void> deleteCar(String id) async {
    await carsCollection.doc(id).delete();
    notifyListeners();
  }
}
