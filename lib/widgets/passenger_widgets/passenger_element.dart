import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PassengerTileElement extends StatelessWidget {
  const PassengerTileElement({required this.passenger, Key? key})
      : super(key: key);

  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        cardColor: Colors.white,
      ),
      child: Card(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              passenger.user.name,
              style: const TextStyle(
                fontSize: 18.0,
              ),
            ),
            serviceTileTitle(),
            const SizedBox(
              height: 10.0,
            ),
            passenger.isAccepted
                ? const Text(
                    "A felhasználó elfogadásra került.",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Provider.of<ServiceProvider>(context, listen: false)
                          .updateAcceptPassenger(passenger.service.id,
                              passenger.user.id, passenger.id);
                    },
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Elfogadás'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceTileTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Colors.black),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Honnan:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            passenger.service.placeFrom.address,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Hová:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            passenger.service.placeTo.address,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(passenger.service.date),
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
