import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/passenger.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/widgets/passenger_widgets/passenger_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassengerList extends StatefulWidget {
  const PassengerList({Key? key}) : super(key: key);

  @override
  State<PassengerList> createState() => _PassengerListState();
}

class _PassengerListState extends State<PassengerList> {
  @override
  Widget build(BuildContext context) {
    String? userId =
        Provider.of<LoggedUserProvider>(context, listen: false).user?.id;
    return StreamBuilder(
      stream: Provider.of<ServiceProvider>(context)
          .getFromFirebaseByLoggedUser(userId!),
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
                child: Text('Nincsenek utasaim.'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int serviceIndex) {
                  var service = documents[serviceIndex].data() as Service;
                  return FutureBuilder(
                      future: Provider.of<ServiceProvider>(context)
                          .getPassengersForService(service.id),
                      builder: (context, snapshot) {
                        var passengers = snapshot.data == null
                            ? []
                            : snapshot.data as List<Passenger>;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: passengers.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder:
                                (BuildContext context, int passengerIndex) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: PassengerTileElement(
                                    passenger: passengers[passengerIndex]),
                              );
                            });
                      });
                },
              );
            }
          }
        }
      },
    );
  }
}
