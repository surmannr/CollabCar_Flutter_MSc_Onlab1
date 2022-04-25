import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/widgets/service_widgets/service_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesByCreator extends StatefulWidget {
  const ServicesByCreator({Key? key}) : super(key: key);

  @override
  State<ServicesByCreator> createState() => _ServicesByCreatorState();
}

class _ServicesByCreatorState extends State<ServicesByCreator> {
  void delete(String id, Service service) {
    Provider.of<ServiceProvider>(context, listen: false)
        .deleteServiceElement(id);
  }

  @override
  Widget build(BuildContext context) {
    var userId =
        Provider.of<LoggedUserProvider>(context, listen: false).user!.id;
    return StreamBuilder(
        stream: Provider.of<ServiceProvider>(context)
            .getFromFirebaseByLoggedUser(userId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final documents = snapshot.data?.docs ?? [];
            if (snapshot.error != null) {
              // ...
              // Do error handling stuff
              return const Center(
                child: Text('Hiba történt!'),
              );
            } else {
              if (snapshot.hasData && documents.isEmpty) {
                return const Center(
                  child: Text('Nincsen szolgáltatás létrehozva.'),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                        future: Provider.of<ServiceProvider>(context)
                            .getPassengersForService(documents[index].id),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Passenger>> snapshot) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ServiceTile(
                              service: documents[index].data()! as Service,
                              isCreatedServices: true,
                              fun: delete,
                              freeSeatingCapacity:
                                  (documents[index].data()! as Service)
                                          .selectedCar
                                          .seatingCapacity -
                                      (snapshot.data?.length ?? 0),
                            ),
                          );
                        },
                      );
                    });
              }
            }
          }
        });
  }
}
