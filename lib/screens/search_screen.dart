import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollabCar'),
      ),
      drawer: const MainDrawer(),
      body: const Text('sdsdasdasdasdasdasdasds'),
    );
  }
}
