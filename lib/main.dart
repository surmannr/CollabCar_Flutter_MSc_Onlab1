import 'package:collabcar/providers/favourite_search_provider.dart';
import 'package:collabcar/providers/history_provider.dart';
import 'package:collabcar/providers/search_provider.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/main_screen.dart';
import 'package:collabcar/screens/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
        )
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
        home: const MainScreen(),
        routes: {
          SearchScreen.routeName: (context) => const SearchScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
        },
      ),
    );
  }
}
