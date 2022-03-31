import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/helpers/auth.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/screens/main_screen.dart';
import 'package:collabcar/widgets/auth_widgets/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collabcar/models/user.dart' as my_user;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitLoginForm(String email, String password) async {
    String message = "Hiba a bejelentkezés során";
    try {
      String? userId =
          await Auth.signInWithEmailAndPassword(email, password, context);

      if (userId != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
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
          Flexible(
            child: Container(
              color: const Color.fromRGBO(246, 246, 246, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Bejelentkezés',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LoginForm(submitLogin: _submitLoginForm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
