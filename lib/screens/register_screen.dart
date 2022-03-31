import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/helpers/auth.dart';
import 'package:collabcar/widgets/auth_widgets/register_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collabcar/models/user.dart' as my_user;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitRegisterForm(String name, String email, String password,
      DateTime birthDate, String telephoneNumber, String imageUrl) async {
    String message = "Hiba a regisztráció során";
    try {
      await Auth.createUserWithEmailAndPassword(
          name, email, password, birthDate, telephoneNumber, imageUrl);
    } on PlatformException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message == null ? message : err.message!),
        backgroundColor: Colors.red.shade700,
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor.withAlpha(235),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Regisztrálás',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RegisterForm(submitRegister: _submitRegisterForm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
