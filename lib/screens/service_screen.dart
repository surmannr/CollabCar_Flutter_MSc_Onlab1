import 'package:collabcar/models/search.dart';
import 'package:collabcar/widgets/menu/main_drawer.dart';
import 'package:collabcar/widgets/service_widgets/services_by_creator.dart';
import 'package:collabcar/widgets/service_widgets/services_by_search.dart';

import 'package:flutter/material.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({this.search, Key? key}) : super(key: key);

  static const routeName = '/service';

  final Search? search;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollabCar'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: widget.search == null
            ? const ServicesByCreator()
            : ServicesBySearch(
                search: widget.search!,
              ),
      ),
    );
  }
}
