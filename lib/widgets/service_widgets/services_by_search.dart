import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collabcar/models/search.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesBySearch extends StatelessWidget {
  const ServicesBySearch({required this.search, Key? key}) : super(key: key);

  final Search search;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<ServiceProvider>(context)
          .servicesFilteredBySearch(search),
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
              return SingleChildScrollView(
                child: Column(
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
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text('HELLO')
                            ],
                          ),
                        ),
                      ),
                      itemCount: documents.length,
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
