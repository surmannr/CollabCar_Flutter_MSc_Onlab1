import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ServiceTile extends StatelessWidget {
  ServiceTile(
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

  final GlobalKey expansionTileKey = GlobalKey();

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;

    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        cardColor: Colors.white,
      ),
      child: Card(
        child: ExpansionTile(
          key: expansionTileKey,
          onExpansionChanged: (isExpanded) {
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          },
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
                        serviceTileBoolen("??llat", service.canTransportPets),
                        serviceTileBoolen(
                            "Bicikli", service.canTransportBicycle),
                        serviceTileBoolen("Aut??p??lya", service.isGoingHighway),
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
                            child: const Text('T??rl??s'),
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
                                      content: Text('Sikeresen jelentkez??s'),
                                      backgroundColor: Colors.green,
                                    ));
                                  },
                            clipBehavior: Clip.hardEdge,
                            child: const Text('Jelentkez??s'),
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
            'J??rm?? r??szletek',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("T??pus:", service.selectedCar.type),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "Rendsz??m:", service.selectedCar.registrationNumber),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("??vj??rat:", service.selectedCar.year.toString()),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("??sszes f??r??helyek sz??ma:",
            (service.selectedCar.seatingCapacity).toString() + " f??"),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Szabad f??r??helyek sz??ma:",
            (freeSeatingCapacity).toString() + " f??"),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement("Csomagtart?? t??rfogata:",
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
          '??r:',
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
            'Hov??:',
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
