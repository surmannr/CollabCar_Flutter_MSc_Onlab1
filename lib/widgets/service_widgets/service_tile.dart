import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile(
      {required this.service,
      required this.isCreatedServices,
      required this.fun,
      required this.freeSeatingCapacity,
      Key? key})
      : super(key: key);

  final Service service;
  final bool isCreatedServices;
  final void Function(String serviceId, Service service) fun;

  final int freeSeatingCapacity;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        cardColor: Colors.white,
      ),
      child: Card(
        child: ExpansionTile(
          textColor: Colors.black,
          title: serviceTileTitle(),
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, bottom: 25.0, right: 25.0),
              child: Column(
                children: [
                  serviceTilePrice(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.black38),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        serviceTileBoolen("Állat", service.canTransportPets),
                        serviceTileBoolen(
                            "Bicikli", service.canTransportBicycle),
                        serviceTileBoolen("Autópálya", service.isGoingHighway),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  serviceTileCar(),
                  isCreatedServices
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => fun(service.id, service),
                            clipBehavior: Clip.hardEdge,
                            child: const Text('Törlés'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: freeSeatingCapacity == 0
                                ? null
                                : () {
                                    fun(service.id, service);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Sikeresen jelentkezés'),
                                      backgroundColor: Colors.green,
                                    ));
                                  },
                            clipBehavior: Clip.hardEdge,
                            child: const Text('Jelentkezés'),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceTileCar() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Jármű részletek',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Típus:", service.selectedCar.type),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "Rendszám:", service.selectedCar.registrationNumber),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Évjárat:", service.selectedCar.year.toString()),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Összes férőhelyek száma:",
            (service.selectedCar.seatingCapacity).toString() + " fő"),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Szabad férőhelyek száma:",
            (freeSeatingCapacity).toString() + " fő"),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Csomagtartó térfogata:",
            service.selectedCar.trunkCapacity.toString() + " liter"),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget serviceTileCarElement(String title, String data) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget serviceTilePrice() {
    return Row(
      children: [
        const Text(
          'Ár:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          service.price.toString() + " Ft",
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget serviceTileBoolen(String title, bool data) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        data
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : const Icon(
                Icons.cancel,
                color: Colors.red,
              )
      ],
    );
  }

  Widget serviceTileTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Honnan:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            service.placeFrom.address,
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
            service.placeTo.address,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(service.date),
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Divider(color: Colors.black),
        ],
      ),
    );
  }
}
