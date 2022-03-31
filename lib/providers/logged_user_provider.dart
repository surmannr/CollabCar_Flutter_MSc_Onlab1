import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/helpers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:collabcar/models/user.dart' as my_user;

class LoggedUserProvider with ChangeNotifier {
  my_user.User? user;
  IsAuth isAuthenticated = IsAuth.signedOut;

  Future<void> login(User fireBaseUser) async {
    var users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<my_user.User>(
            fromFirestore: (snapshot, _) =>
                my_user.User.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson());

    var docUser = await users.doc(fireBaseUser.uid).get();

    user = docUser.data();

    isAuthenticated = IsAuth.signedIn;
  }
}
