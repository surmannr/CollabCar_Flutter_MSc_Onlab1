import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);

  runApp(const CollabCarApp());
}

class CollabCarApp extends StatelessWidget {
  const CollabCarApp({Key? key}) : super(key: key);

  final Color? colorOne = const Color.fromRGBO(7, 153, 146, 1.0);
  final Color? colorSecond = const Color.fromRGBO(199, 236, 238, 1.0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CollabCar',
      theme: ThemeData(
        primaryColor: colorOne,
        backgroundColor: colorSecond,
        canvasColor: const Color(0xf6f6f6f6),
        appBarTheme: AppBarTheme(
          color: colorOne,
          elevation: 1,
          foregroundColor: colorSecond,
        ),
        textTheme: const TextTheme().apply(displayColor: Colors.black),
      ),
      home: const SearchScreen(),
      routes: {
        SearchScreen.routeName: (context) => const SearchScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
    );
  }
}
