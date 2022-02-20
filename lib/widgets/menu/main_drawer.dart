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
      buildListTile('Profilbeállítások', Icons.settings, () {
        //Navigator.of(context).pushReplacementNamed('/');
      }),
      buildListTile('Gépjárműbeállítások', Icons.car_rental, () {
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
                  buildListTile('Keresés', Icons.search, () {
                    //Navigator.of(context).pushReplacementNamed('/');
                  }),
                  buildListTile('Foglalások', Icons.flag, () {
                    //Navigator.of(context).pushReplacementNamed('/');
                  }),
                  ...buildSameTilesForBoth(),
                ],
              ),
              Column(
                children: [
                  buildListTile('Utasaim', Icons.search, () {
                    //Navigator.of(context).pushReplacementNamed('/');
                  }),
                  buildListTile('Hirdetéseim', Icons.flag, () {
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
