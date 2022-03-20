import 'package:collabcar/screens/main_screen.dart';
import 'package:collabcar/screens/search_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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
        //Navigator.of(context).pushReplacementNamed('/');
      }),
      buildListTile('Gépjárműbeállítások', Icons.airport_shuttle_rounded, () {
        //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
      }),
      buildListTile('Kijelentkezés', Icons.logout, () {
        //Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Drawer(
        backgroundColor: Theme.of(context).canvasColor,
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
          const TabBar(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Utas',
                height: 20.0,
              ),
              Tab(
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
                  buildListTile('Foglalások', Icons.book_rounded, () {
                    //Navigator.of(context).pushReplacementNamed('/');
                  }),
                  ...buildSameTilesForBoth(),
                ],
              ),
              Column(
                children: [
                  buildListTile('Utasaim', Icons.assignment_ind_rounded, () {
                    //Navigator.of(context).pushReplacementNamed('/');
                  }),
                  buildListTile('Hirdetéseim', Icons.analytics, () {
                    //Navigator.of(context).pushReplacementNamed('/');
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
