import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/passenger_widgets/passenger_list.dart';
import 'package:flutter/material.dart';

class PassengerScreen extends StatefulWidget {
  const PassengerScreen({Key? key}) : super(key: key);

  static const routeName = '/passengers';

  @override
  State<PassengerScreen> createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utasaim'),
      ),
      drawer: const MainDrawer(),
      body: const PassengerList(),
    );
  }
}
