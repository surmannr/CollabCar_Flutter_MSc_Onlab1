import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/search.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/widgets/service_widgets/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesBySearch extends StatefulWidget {
  const ServicesBySearch({required this.search, Key? key}) : super(key: key);

  final Search search;

  @override
  State<ServicesBySearch> createState() => _ServicesBySearchState();
}

class _ServicesBySearchState extends State<ServicesBySearch> {
  void apply(String id, Service service) {
    Provider.of<ServiceProvider>(context, listen: false).addNewPassenger(
        service, Provider.of<LoggedUserProvider>(context, listen: false).user!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<ServiceProvider>(context)
          .servicesFilteredBySearch(widget.search),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final documents = snapshot.data!.docs;
          if (snapshot.error != null) {
            // ...
            // Do error handling stuff
            return const Center(
              child: Text('Hiba történt!'),
            );
          } else {
            if (snapshot.hasData && documents.isEmpty) {
              return const Center(
                child: Text('Nincs találat a keresésre.'),
              );
            } else {
              var services = documents
                  .map((e) => e.data() as Service)
                  .where((element) => element.placeFrom.address
                      .toLowerCase()
                      .contains(
                          widget.search.placeFrom?.address.toLowerCase() ?? ""))
                  .where((element) => element.placeTo.address
                      .toLowerCase()
                      .contains(
                          widget.search.placeTo?.address.toLowerCase() ?? ""))
                  .where((element) => element.date.isAfter(widget.search.date))
                  .toList();
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Keresési találatok",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: Provider.of<ServiceProvider>(context)
                              .getPassengersForService(services[index].id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Passenger>> snapshot) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ServiceTile(
                                service: services[index],
                                isCreatedServices: false,
                                fun: apply,
                                freeSeatingCapacity: (services[index])
                                        .selectedCar
                                        .seatingCapacity -
                                    (snapshot.data?.length ?? 0),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: services.length,
                    ),
                  ],
                ),
              );
            }
          }
        }
      },
    );
  }
}
