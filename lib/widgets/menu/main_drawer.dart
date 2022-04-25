import 'package:collabcar/helpers/auth.dart';
import 'package:collabcar/models/user.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/screens/car_settings_screen.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/screens/main_screen.dart';
import 'package:collabcar/screens/profile_settings_screen.dart';
import 'package:collabcar/screens/reservation_screen.dart';
import 'package:collabcar/screens/search_screen.dart';
import 'package:collabcar/screens/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool hasCarpoolService = false;

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  List<Widget> buildSameTilesForBoth() {
    return [
      const Divider(
        color: Colors.black,
        thickness: 1.4,
        indent: 15.0,
        endIndent: 15.0,
      ),
      buildListTile('Profilbeállítások', Icons.account_box, () {
        Navigator.of(context)
            .pushReplacementNamed(ProfileSettingsScreen.routeName);
      }),
      buildListTile('Gépjárműbeállítások', Icons.airport_shuttle_rounded, () {
        Navigator.of(context).pushReplacementNamed(CarSettingsScreen.routeName);
      }),
      buildListTile('Kijelentkezés', Icons.logout, () {
        Auth.signOut();
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final User? user =
        Provider.of<LoggedUserProvider>(context, listen: false).user;

    if (user != null) {
      setState(() {
        hasCarpoolService = user.hasCarpoolService;
      });
    }

    return DefaultTabController(
      length: hasCarpoolService ? 2 : 1,
      child: Drawer(
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1.0),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            labelColor: Colors.black,
            tabs: [
              const Tab(
                text: 'Utas',
                height: 20.0,
              ),
              if (hasCarpoolService)
                const Tab(
                  text: 'Sofőr',
                ),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              Column(
                children: [
                  buildListTile(
                      'Keresés',
                      Icons.search,
                      () async => await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ))),
                  buildListTile('Foglalások', Icons.book_rounded, () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReservationScreen(),
                        ));
                  }),
                  ...buildSameTilesForBoth(),
                ],
              ),
              if (hasCarpoolService)
                Column(
                  children: [
                    buildListTile('Utasaim', Icons.assignment_ind_rounded, () {
                      //Navigator.of(context).pushReplacementNamed('/');
                    }),
                    buildListTile('Hirdetéseim', Icons.analytics, () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServiceScreen(
                              search: null,
                            ),
                          ));
                    }),
                    ...buildSameTilesForBoth(),
                  ],
                ),
            ]),
          ),
        ]),
      ),
    );
  }
}
