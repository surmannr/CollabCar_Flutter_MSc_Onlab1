import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/settings_widgets/user_cars_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarSettingsScreen extends StatefulWidget {
  const CarSettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/car-settings';

  @override
  State<CarSettingsScreen> createState() => _CarSettingsScreenState();
}

class _CarSettingsScreenState extends State<CarSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Járműbeállítások'),
      ),
      drawer: const MainDrawer(),
      body: const UserCarsListWidget(),
    );
  }
}
