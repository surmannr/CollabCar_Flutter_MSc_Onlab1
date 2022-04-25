import 'package:collabcar/models/service_application.dart';
import 'package:flutter/material.dart';

class ReservationElement extends StatelessWidget {
  const ReservationElement({required this.reservation, Key? key})
      : super(key: key);

  final ServiceApplication reservation;

  @override
  Widget build(BuildContext context) {
    return Text(reservation.service.placeFrom.address);
  }
}
