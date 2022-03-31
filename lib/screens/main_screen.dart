import 'package:collabcar/helpers/auth.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/screens/favourite_screen.dart';
import 'package:collabcar/screens/history_screen.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/search_screen.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final IsAuth isAuthenticated =
        Provider.of<LoggedUserProvider>(context).isAuthenticated;
    switch (isAuthenticated) {
      case IsAuth.signedIn:
        return const SearchScreen();
      case IsAuth.signedOut:
        return const LoginScreen();
    }
  }
}
