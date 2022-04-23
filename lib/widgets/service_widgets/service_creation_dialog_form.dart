import 'package:collabcar/helpers/location_helper.dart';
import 'package:collabcar/models/car.dart';
import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/service.dart';
import 'package:collabcar/screens/map_picker_screen.dart';
import 'package:collabcar/widgets/search_widgets/custom_dropdown_with_label.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class ServiceCreationForm extends StatefulWidget {
  const ServiceCreationForm(
      {required this.saveNewService, required this.cars, Key? key})
      : super(key: key);

  final void Function(Service? service, bool create) saveNewService;
  final List<Car> cars;

  @override
  State<ServiceCreationForm> createState() => _ServiceCreationDialogFormState();
}

class _ServiceCreationDialogFormState extends State<ServiceCreationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Place? placeFrom;
  Place? placeTo;
  DateTime date = DateTime.now();
  int price = 0;
  bool canTransportPets = false;
  bool canTransportBicycle = false;
  bool isGoingHighway = false;
  String creatorUserId = "";
  Car? selectedCar;
  int selectedCarIndex = -1;

  var placeFromTextField = TextEditingController();
  var placeToTextField = TextEditingController();
  var time = TextEditingController();

  void _trySubmit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      if (placeFrom != null && placeTo != null && selectedCar != null) {
        Service service = Service(
          placeFrom: placeFrom!,
          placeTo: placeTo!,
          date: date,
          price: price,
          canTransportPets: canTransportPets,
          canTransportBicycle: canTransportBicycle,
          isGoingHighway: isGoingHighway,
          creatorUserId: creatorUserId,
          selectedCar: selectedCar!,
        );
        widget.saveNewService(service, true);
      }
    }
  }

  Widget placePickerWidget(String hintText, bool isPlaceFrom) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.place,
          color: Colors.red,
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 250.0,
          margin: const EdgeInsetsDirectional.only(bottom: 10.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Az útvonal kitöltése kötelező!";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
            ),
            controller: isPlaceFrom ? placeFromTextField : placeToTextField,
            onTap: () => _selectOnMap(isPlaceFrom),
          ),
        ),
      ],
    );
  }

  Future<void> _selectOnMap(bool isPlaceFrom) async {
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            builder: (ctx) => MapPickerScreen(
                  isSelecting: true,
                  isPlaceFromSelection: isPlaceFrom,
                )));

    if (selectedLocation == null) {
      return;
    }

    final address = await LocationHelper.getPlaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);

    if (isPlaceFrom) {
      placeFrom = Place(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude,
          address: address);
    } else {
      placeTo = Place(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude,
          address: address);
    }

    setState(() {
      if (isPlaceFrom) {
        placeFromTextField.text = placeFrom!.address;
      } else {
        placeToTextField.text = placeTo!.address;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              placePickerWidget("Honnan", true),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      onPressed: () {
                        Place? placeFromTemp = placeFrom;
                        Place? placeToTemp = placeTo;

                        placeFrom = placeToTemp;
                        placeFromTextField.text =
                            placeFrom != null ? placeFrom!.address : '';
                        placeTo = placeFromTemp;
                        placeToTextField.text =
                            placeTo != null ? placeTo!.address : '';
                      },
                      icon: const Icon(
                        Icons.sync_alt_outlined,
                      ),
                    ),
                  ),
                ],
              ),
              placePickerWidget("Hová", false),
              const SizedBox(
                height: 10,
              ),
              DateTimeField(
                format: DateFormat("yyyy-MM-dd"),
                initialValue: DateTime.now(),
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: Color.fromARGB(255, 138, 211, 140),
                  ),
                ),
                onChanged: (currentValue) {
                  if (currentValue != null) {
                    date = DateTime(
                      currentValue.year,
                      currentValue.month,
                      currentValue.day,
                      date.hour,
                      date.minute,
                    );
                  }
                },
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime.now().add(const Duration(days: -1)),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Az idő kitöltése kötelező!";
                  }
                  return null;
                },
                controller: time,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Időpont',
                ),
                onTap: () {
                  final timepick = showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  timepick.then((value) => {
                        if (value != null)
                          {
                            time.text = '${value.hour}:${value.minute}',
                            date = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              value.hour,
                              value.minute,
                            )
                          }
                      });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Az ár kitöltése kötelező!";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Szolgáltatás ára',
                ),
                onSaved: (value) {
                  if (value != null) {
                    price = int.parse(value);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomDropdownWithLabel(
                placeHolderText: 'Állatok szállítása',
                labelText: 'Állatok szállítása',
                data: canTransportPets,
                func: (value) {
                  canTransportPets = value['value'];
                },
                search: false,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomDropdownWithLabel(
                placeHolderText: 'Kerékpárszállítás',
                labelText: 'Kerékpárszállítás',
                data: canTransportBicycle,
                func: (value) {
                  canTransportBicycle = value['value'];
                },
                search: false,
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomDropdownWithLabel(
                placeHolderText: 'Autópálya',
                labelText: 'Autópálya',
                data: isGoingHighway,
                func: (value) {
                  isGoingHighway = value['value'];
                },
                search: false,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Autó kiválasztása",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cars.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCarIndex = index;
                        selectedCar = widget.cars[index];
                      });
                    },
                    child: GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                            color: selectedCarIndex == index
                                ? Colors.green.shade100
                                : null,
                            border: Border.all(color: Colors.green)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.cars[index].type,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              widget.cars[index].registrationNumber,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 30.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
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
                        widget.saveNewService(null, false);
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
      ),
    );
  }
}
