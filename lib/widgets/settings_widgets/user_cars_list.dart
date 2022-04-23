import 'package:collabcar/models/car.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/widgets/settings_widgets/car_element.dart';
import 'package:collabcar/widgets/settings_widgets/car_settings_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserCarsListWidget extends StatefulWidget {
  const UserCarsListWidget({Key? key}) : super(key: key);

  @override
  State<UserCarsListWidget> createState() => _UserCarsListWidgetState();
}

class _UserCarsListWidgetState extends State<UserCarsListWidget> {
  int selectedIndex = -1;
  Car? selectedCar;
  bool newCarForm = false;

  void cancel() {
    setState(() {
      selectedCar = null;
      newCarForm = false;
      selectedIndex = -1;
    });
  }

  void _submitCarSettingsForm(Car? car) async {
    String message = "Hiba a mentés során";
    try {
      if (car != null) {
        Provider.of<LoggedUserProvider>(context, listen: false)
            .createOrModifyUserCar(car);
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sikeresen elmentve'),
        backgroundColor: Colors.green,
      ));
    } on PlatformException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.message == null ? message : err.message!),
        backgroundColor: Colors.red.shade700,
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream:
          Provider.of<LoggedUserProvider>(context).carsCollection.snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final documents = snapshot.data!.docs;
          if (snapshot.error != null) {
            // ...
            // Do error handling stuff
            return const Center(
              child: Text('An error occurred!'),
            );
          } else {
            if (snapshot.hasData && documents.isEmpty) {
              return const Center(
                child: Text('Nincs kedvenc keresési előzményed.'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onLongPress: () {
                                if (selectedIndex == index) {
                                  setState(() {
                                    selectedIndex = -1;
                                    selectedCar = null;
                                  });
                                } else {
                                  setState(() {
                                    selectedIndex = index;
                                    selectedCar =
                                        documents[selectedIndex].data() as Car;
                                  });
                                }
                              },
                              child: CarElement(
                                  car: documents[index].data() as Car,
                                  selected: index == selectedIndex),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: documents.length,
                  ),
                  selectedCar != null
                      ? CarSettingsForm(
                          submitCarSettings: _submitCarSettingsForm,
                          car: selectedCar,
                          cancel: cancel,
                        )
                      : (!newCarForm)
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      newCarForm = true;
                                    });
                                  },
                                  clipBehavior: Clip.hardEdge,
                                  child: const Text('Új autó hozzáadása'),
                                ),
                              ),
                            )
                          : CarSettingsForm(
                              submitCarSettings: _submitCarSettingsForm,
                              car: null,
                              cancel: cancel,
                            ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
