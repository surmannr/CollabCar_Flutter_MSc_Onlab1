import 'package:collabcar/helpers/location_helper.dart';
import 'package:collabcar/models/place.dart';
import 'package:collabcar/screens/map_picker_screen.dart';
import 'package:collabcar/widgets/search_widgets/custom_textfield_with_label.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import '../../providers/search_provider.dart';

class StepOneSearch extends StatefulWidget {
  const StepOneSearch({required this.searchData, Key? key}) : super(key: key);

  final SearchProvider searchData;

  @override
  State<StepOneSearch> createState() => _StepOneSearchState();
}

class _StepOneSearchState extends State<StepOneSearch> {
  var placeFromTextField = TextEditingController();
  var placeToTextField = TextEditingController();
  var date = TextEditingController();
  var time = TextEditingController();

  Widget placePickerWidget(
      String hintText, bool isPlaceFrom, SearchProvider searchData) {
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
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
            ),
            controller: isPlaceFrom ? placeFromTextField : placeToTextField,
            onTap: () => _selectOnMap(isPlaceFrom, searchData),
          ),
        ),
      ],
    );
  }

  Future<void> _selectOnMap(bool isPlaceFrom, SearchProvider searchData) async {
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
      searchData.search.placeFrom = Place(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude,
          address: address);
    } else {
      searchData.search.placeTo = Place(
          latitude: selectedLocation.latitude,
          longitude: selectedLocation.longitude,
          address: address);
    }

    setState(() {
      if (isPlaceFrom) {
        placeFromTextField.text = searchData.search.placeFrom!.address;
      } else {
        placeToTextField.text = searchData.search.placeTo!.address;
      }
    });
  }

  Widget dateButtonWidget(String text, VoidCallback func) {
    return Expanded(
      child: TextButton(
        onPressed: func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromARGB(255, 138, 211, 140),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    return SingleChildScrollView(
      child: Column(
        children: [
          placePickerWidget("Honnan", true, widget.searchData),
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
                    Place? placeFromTemp = widget.searchData.search.placeFrom;
                    Place? placeToTemp = widget.searchData.search.placeTo;

                    widget.searchData.search.placeFrom = placeToTemp;
                    placeFromTextField.text =
                        widget.searchData.search.placeFrom != null
                            ? widget.searchData.search.placeFrom!.address
                            : '';
                    widget.searchData.search.placeTo = placeFromTemp;
                    placeToTextField.text =
                        widget.searchData.search.placeTo != null
                            ? widget.searchData.search.placeTo!.address
                            : '';
                  },
                  icon: const Icon(
                    Icons.sync_alt_outlined,
                  ),
                ),
              ),
            ],
          ),
          placePickerWidget("Hová", false, widget.searchData),
          const SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Utazás dátuma',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DateTimeField(
                format: DateFormat("yyyy-MM-dd"),
                initialValue: DateTime.now(),
                controller: date,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.date_range,
                    color: Color.fromARGB(255, 138, 211, 140),
                  ),
                ),
                onChanged: (currentValue) {
                  if (currentValue != null) {
                    widget.searchData.search.date = DateTime(
                      currentValue.year,
                      currentValue.month,
                      currentValue.day,
                      widget.searchData.search.date.hour,
                      widget.searchData.search.date.minute,
                    );
                  }
                },
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dateButtonWidget(
                    "Ma", () => date.text = formatter.format(DateTime.now())),
                const SizedBox(
                  width: 5.0,
                ),
                dateButtonWidget(
                    "Holnap",
                    () => date.text = formatter
                        .format(DateTime.now().add(const Duration(days: 1)))),
                const SizedBox(
                  width: 5.0,
                ),
                dateButtonWidget(
                    "Holnapután",
                    () => date.text = formatter
                        .format(DateTime.now().add(const Duration(days: 2)))),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          CustomTextFieldWithLabel(
            textFieldController: time,
            labelText: 'Utazás időpontja',
            hintText: 'Utazás időpontja (óra, perc)',
            inputType: TextInputType.text,
            icon: Icons.alarm,
            onFunction: (value) {
              final timepick = showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              timepick.then((value) => {
                    if (value != null)
                      {
                        time.text = '${value.hour}:${value.minute}',
                        widget.searchData.search.date = DateTime(
                          widget.searchData.search.date.year,
                          widget.searchData.search.date.month,
                          widget.searchData.search.date.day,
                          value.hour,
                          value.minute,
                        )
                      }
                  });
            },
          ),
        ],
      ),
    );
  }
}
