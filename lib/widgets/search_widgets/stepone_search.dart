import 'package:collabcar/helpers/LocationHelper.dart';
import 'package:collabcar/models/place.dart';
import 'package:collabcar/models/search.dart';
import 'package:collabcar/screens/map_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StepOneSearch extends StatefulWidget {
  const StepOneSearch({Key? key}) : super(key: key);

  @override
  State<StepOneSearch> createState() => _StepOneSearchState();
}

class _StepOneSearchState extends State<StepOneSearch> {
  Search search = Search();

  var placeFromTextField = TextEditingController();
  var placeToTextField = TextEditingController();

  Widget placePickerWidget(String hintText, bool isPlaceFrom) {
    return Row(
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
          margin: const EdgeInsetsDirectional.only(bottom: 20.0),
          child: TextField(
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
    setState(() async {
      final selectedLocation =
          await Navigator.of(context).push<LatLng>(MaterialPageRoute(
              builder: (ctx) => const MapPickerScreen(
                    isSelecting: true,
                  )));

      if (selectedLocation == null) {
        return;
      }

      final address = await LocationHelper.getPlaceAddress(
          selectedLocation.latitude, selectedLocation.longitude);

      if (isPlaceFrom) {
        search.placeFrom = Place(
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
            address: address);

        placeFromTextField.text = search.placeFrom!.address;
      } else {
        search.placeTo = Place(
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
            address: address);

        placeToTextField.text = search.placeTo!.address;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        placePickerWidget("Honnan", true),
        Row(
          children: const [
            Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ],
        ),
        placePickerWidget("Hová", false),
      ],
    );
  }
}
