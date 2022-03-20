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
    return Column(
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
        FutureBuilder(
            future: Provider.of<ServiceProvider>(context)
                .servicesFilteredBySearch(search),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  // ...
                  // Do error handling stuff
                  return const Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  if (snapshot.hasData &&
                      (snapshot.data as List<Service>).isEmpty) {
                    return const Center(
                      child: Text('Nincs találat a keresett szolgáltatásra.'),
                    );
                  } else {
                    return Consumer<ServiceProvider>(
                      builder: (context, value, child) => Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                      child: Text(value
                                          .services[index].selectedCar.type)),
                                ],
                              ),
                            ),
                          ),
                          itemCount: value.services.length,
                        ),
                      ),
                    );
                  }
                }
              }
            })
      ],
    );
  }
}
