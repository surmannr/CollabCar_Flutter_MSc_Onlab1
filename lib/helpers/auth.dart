import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collabcar/models/user.dart' as my_user;

enum IsAuth {
  signedIn,
  signedOut,
}

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<String?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    if (authResult.user == null) {
      return null;
    }

    await Provider.of<LoggedUserProvider>(context, listen: false)
        .login(authResult.user!);

    return authResult.user!.uid;
  }

  static Future<String?> createUserWithEmailAndPassword(
      String name,
      String email,
      String password,
      DateTime birthDate,
      String telephoneNumber,
      String imageUrl) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (authResult.user == null) {
      return null;
    }

    if (authResult.user != null) {
      var user = my_user.User(
          id: authResult.user!.uid,
          email: email,
          password: password,
          name: name,
          hasCarpoolService: false,
          birthDate: birthDate,
          telephone: telephoneNumber,
          imageUrl: imageUrl);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set(user.toJson());
    }

    return authResult.user!.uid;
  }

  static Future<User?> currentUser() async {
    final User? user = _firebaseAuth.currentUser;
    return user;
  }

  static Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
