import 'package:background_location/background_location.dart';
import 'package:collabcar/helpers/auth.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/screens/favourite_screen.dart';
import 'package:collabcar/screens/history_screen.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../widgets/menu/main_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    SearchScreen(),
    FavouriteScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollabCar'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: _pages.elementAt(_selectedTabIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
          canvasColor: Theme.of(context).primaryColor,
          cardColor: Theme.of(context).cardColor,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).cardColor,
          selectedIconTheme: const IconThemeData(
            size: 40,
          ),
          unselectedItemColor: Theme.of(context).canvasColor,
          currentIndex: _selectedTabIndex,
          mouseCursor: SystemMouseCursors.grab,
          elevation: 0,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Keresés',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Kedvencek',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Előzmények',
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  void locationSharing(User user) async {
    if (await Permission.location.request().isGranted) {
      await BackgroundLocation.setAndroidNotification(
        title: 'Background service is running',
        message: 'Background location in progress',
        icon: '@mipmap/ic_launcher',
      );
      await BackgroundLocation.startLocationService(distanceFilter: 20);
      BackgroundLocation.getLocationUpdates((location) {
        databaseReference
            .child("location")
            .child(user.uid)
            .set({"locationData": location.toMap()});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: Auth.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            Provider.of<LoggedUserProvider>(context, listen: false)
                .login(snapshot.data!);
            locationSharing(snapshot.data!);

            return const MainScreen();
          }
          return const LoginScreen();
        });
  }
}
