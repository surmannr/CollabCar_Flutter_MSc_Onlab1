import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/service_application.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/widgets/reservation_widgets/reservation_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({Key? key}) : super(key: key);

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Provider.of<LoggedUserProvider>(context).getLoggedUserReservations(),
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
                child: Text('Nincsenek foglalások.'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ReservationElement(
                        reservation: ServiceApplication.fromJson(
                            documents[index].data() as Map<String, dynamic>)),
                  );
                },
              );
            }
          }
        }
      },
    );
  }
}
