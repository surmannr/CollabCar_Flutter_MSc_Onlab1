import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/reservation_widgets/reservation_list.dart';
import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  static const routeName = '/reservations';

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foglalásaim'),
      ),
      drawer: const MainDrawer(),
      body: const ReservationList(),
    );
  }
}
