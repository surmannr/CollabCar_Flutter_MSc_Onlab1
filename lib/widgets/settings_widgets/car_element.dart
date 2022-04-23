import 'package:collabcar/models/car.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CarElement extends StatelessWidget {
  const CarElement({required this.car, required this.selected, Key? key})
      : super(key: key);

  final Car car;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Provider.of<LoggedUserProvider>(context, listen: false)
                  .deleteCar(car.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Törlés',
          ),
        ],
      ),
      child: Card(
        shape: (selected)
            ? RoundedRectangleBorder(
                side: BorderSide(
                color: Theme.of(context).cardColor,
                width: 2.0,
              ))
            : null,
        color: Colors.white,
        child: Row(
          children: [
            Flexible(
              child: Image.network(
                "http://via.placeholder.com/350x150",
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car.type,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Text(
                  car.registrationNumber,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
