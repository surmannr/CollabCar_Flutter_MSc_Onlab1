import 'package:collabcar/models/service_application.dart';
import 'package:collabcar/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationElement extends StatelessWidget {
  ReservationElement({required this.reservation, Key? key}) : super(key: key);

  final ServiceApplication reservation;

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
                        serviceTileBoolen(
                            "??llat", reservation.service.canTransportPets),
                        serviceTileBoolen(
                            "Bicikli", reservation.service.canTransportBicycle),
                        serviceTileBoolen(
                            "Aut??p??lya", reservation.service.isGoingHighway),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  serviceTileCar(),
                  SizedBox(
                    width: double.infinity,
                    child: reservation.isAccepted
                        ? ElevatedButton(
                            onPressed: (reservation.service.date
                                        .difference(DateTime.now())
                                        .inHours <
                                    1)
                                ? () => trackPerson(context)
                                : null,
                            clipBehavior: Clip.hardEdge,
                            child: const Text('Nyomk??vet??s'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Nincs elfogadva a szervez?? ??ltal.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.0,
                              ),
                            ),
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

  void trackPerson(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TrackingScreen(
        title: "Sof??r nyomonk??vet??se",
        user: reservation.service.creatorUser,
      ),
    ));
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
        serviceTileCarElement("T??pus:", reservation.service.selectedCar.type),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "Rendsz??m:", reservation.service.selectedCar.registrationNumber),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "??vj??rat:", reservation.service.selectedCar.year.toString()),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "??sszes f??r??helyek sz??ma:",
            (reservation.service.selectedCar.seatingCapacity).toString() +
                " f??"),
        const SizedBox(
          height: 10.0,
        ),
        serviceTileCarElement(
            "Csomagtart?? t??rfogata:",
            reservation.service.selectedCar.trunkCapacity.toString() +
                " liter"),
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
          reservation.service.price.toString() + " Ft",
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
            reservation.service.placeFrom.address,
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
            reservation.service.placeTo.address,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            DateFormat('yyyy-MM-dd HH:mm').format(reservation.service.date),
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
