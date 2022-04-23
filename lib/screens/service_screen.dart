import 'package:collabcar/models/search.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/providers/service_provider.dart';
import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/service_widgets/service_creation_dialog_form.dart';
import 'package:collabcar/widgets/service_widgets/services_by_creator.dart';
import 'package:collabcar/widgets/service_widgets/services_by_search.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({this.search, Key? key}) : super(key: key);

  static const routeName = '/service';

  final Search? search;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool serviceCreation = false;

  void saveService(Service? service, bool create) {
    setState(() {
      serviceCreation = create;
    });

    if (service != null) {
      var userId =
          Provider.of<LoggedUserProvider>(context, listen: false).user!.id;
      service.creatorUserId = userId;
      Provider.of<ServiceProvider>(context, listen: false)
          .addNewServiceElement(service);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sikeresen elmentve'),
        backgroundColor: Colors.green,
      ));
      setState(() {
        serviceCreation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cars = Provider.of<LoggedUserProvider>(context, listen: false).cars;
    return Scaffold(
      appBar: AppBar(
        title: serviceCreation
            ? const Text('Új szolgáltatás')
            : widget.search == null
                ? const Text('Hirdetéseim')
                : const Text('Keresés eredménye'),
      ),
      drawer: const MainDrawer(),
      body: serviceCreation
          ? ServiceCreationForm(
              saveNewService: saveService,
              cars: cars,
            )
          : Center(
              child: widget.search == null
                  ? const ServicesByCreator()
                  : ServicesBySearch(
                      search: widget.search!,
                    ),
            ),
      floatingActionButton: !serviceCreation
          ? FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              label: const Text("Új szolgáltatás felvétele"),
              extendedIconLabelSpacing: 16,
              extendedPadding: const EdgeInsets.all(33.0),
              onPressed: () {
                setState(() {
                  serviceCreation = true;
                });
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
