import 'package:collabcar/models/service.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({required this.service, Key? key}) : super(key: key);

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        textColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
        children: [],
      ),
    );
  }
}
