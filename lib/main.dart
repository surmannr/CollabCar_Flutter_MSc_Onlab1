import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/providers/favourite_search_provider.dart';
import 'package:collabcar/providers/history_provider.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/search_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/screens/car_settings_screen.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/main_screen.dart';
import 'package:collabcar/screens/passenger_screen.dart';
import 'package:collabcar/screens/profile_settings_screen.dart';
import 'package:collabcar/screens/register_screen.dart';
import 'package:collabcar/screens/reservation_screen.dart';
import 'package:collabcar/screens/search_screen.dart';
import 'package:collabcar/screens/service_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, //This line is used for showing the bottom bar
  ]);
  await Firebase.initializeApp();
  runApp(const CollabCarApp());
}

class CollabCarApp extends StatelessWidget {
  const CollabCarApp({Key? key}) : super(key: key);

  final Color? colorOne = const Color.fromRGBO(7, 153, 146, 1.0);
  final Color? colorSecond = const Color.fromRGBO(199, 236, 238, 1.0);
  final Color? colorThird = const Color.fromRGBO(144, 238, 144, 1.0);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SearchProvider(),
        ),
        ChangeNotifierProvider.value(
          value: HistoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FavouriteSearchProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ServiceProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LoggedUserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'CollabCar',
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!),
        theme: ThemeData(
          primaryColor: colorOne,
          backgroundColor: colorSecond,
          cardColor: colorThird,
          canvasColor: const Color(0xf6f6f6f6),
          appBarTheme: AppBarTheme(
            color: colorOne,
            elevation: 1,
            foregroundColor: colorSecond,
          ),
          textTheme: const TextTheme().apply(displayColor: Colors.black),
        ),
        home: const AuthScreen(),
        routes: {
          SearchScreen.routeName: (context) => const SearchScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          ServiceScreen.routeName: (context) => const ServiceScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          ProfileSettingsScreen.routeName: (context) =>
              const ProfileSettingsScreen(),
          CarSettingsScreen.routeName: (context) => const CarSettingsScreen(),
          ReservationScreen.routeName: (context) => const ReservationScreen(),
          PassengerScreen.routeName: (context) => const PassengerScreen(),
        },
      ),
    );
  }
}
