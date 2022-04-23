import 'package:collabcar/models/car.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarSettingsForm extends StatefulWidget {
  const CarSettingsForm(
      {this.car,
      required this.submitCarSettings,
      required this.cancel,
      Key? key})
      : super(key: key);

  final Car? car;
  final void Function(Car? car) submitCarSettings;
  final void Function() cancel;

  @override
  State<CarSettingsForm> createState() => _CarSettingsFormState();
}

class _CarSettingsFormState extends State<CarSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String registrationNumber = "";
  int year = DateTime.now().year;
  String type = "";
  int trunkCapacity = 0;
  int seatCapacity = 0;
  DateTime technicalInspectionExpirationDate = DateTime.now();

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      if (widget.car != null) {
        widget.submitCarSettings(widget.car);
      } else {
        Car newCar = Car(
          id: "",
          registrationNumber: registrationNumber,
          year: year,
          type: type,
          technicalInspectionExpirationDate: technicalInspectionExpirationDate,
          seatingCapacity: seatCapacity,
          trunkCapacity: trunkCapacity,
          imageUrl: "-",
          userId: "",
        );
        widget.submitCarSettings(newCar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A rendszám kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car?.registrationNumber.toUpperCase() ??
                  registrationNumber,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Rendszám',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null
                      ? widget.car!.registrationNumber = value.toUpperCase()
                      : registrationNumber = value.toUpperCase();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Az évjárat kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car?.year.toString() ?? year.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Évjárat',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null
                      ? widget.car!.year = int.parse(value)
                      : year = int.parse(value);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A típus kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car?.type.toString() ?? type,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Típus',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null ? widget.car!.type = value : type = value;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A műszaki vizsga lejárati dátum kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(widget.car!.technicalInspectionExpirationDate)
                  : DateFormat('yyyy-MM-dd')
                      .format(technicalInspectionExpirationDate),
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Műszaki vizsga lejárati dátum',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null
                      ? widget.car!.technicalInspectionExpirationDate =
                          DateTime.parse(value)
                      : technicalInspectionExpirationDate =
                          DateTime.parse(value);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A férőhelyek számának kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car?.seatingCapacity.toString() ??
                  seatCapacity.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Férőhelyek száma',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null
                      ? widget.car!.seatingCapacity = int.parse(value)
                      : seatCapacity = int.parse(value);
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "A csomagtartó kapacitása kitöltése kötelező!";
                }
                return null;
              },
              initialValue: widget.car?.trunkCapacity.toString() ??
                  trunkCapacity.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.article_rounded),
                labelText: 'Csomagtartó kapacitása',
              ),
              onSaved: (value) {
                if (value != null) {
                  widget.car != null
                      ? widget.car!.trunkCapacity = int.parse(value)
                      : trunkCapacity = int.parse(value);
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _trySubmit(context),
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Mentés'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.cancel();
                    },
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Mégse'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
