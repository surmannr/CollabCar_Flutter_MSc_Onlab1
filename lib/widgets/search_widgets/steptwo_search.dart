import 'package:collabcar/widgets/search_widgets/custom_dropdown_with_label.dart';
import 'package:collabcar/widgets/search_widgets/custom_textfield_with_label.dart';
import 'package:flutter/material.dart';

import '../../providers/search_provider.dart';

class StepTwoSearch extends StatefulWidget {
  const StepTwoSearch({required this.searchData, Key? key}) : super(key: key);

  final SearchProvider searchData;

  @override
  State<StepTwoSearch> createState() => _StepTwoSearchState();
}

class _StepTwoSearchState extends State<StepTwoSearch> {
  var minimumSeatController = TextEditingController();
  var maxPriceController = TextEditingController();
  var driverNameController = TextEditingController();
  var transportPetController = TextEditingController();
  var transportBicycleController = TextEditingController();
  var highwayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "További keresési beállítások",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFieldWithLabel(
              textFieldController: minimumSeatController,
              inputType: TextInputType.number,
              labelText: 'Minimum szabad helyek száma',
              hintText: 'Hány utas veszi igénybe a szolgáltatást?',
              onTapFunction: null,
              icon: Icons.airline_seat_recline_normal_sharp),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFieldWithLabel(
              textFieldController: maxPriceController,
              inputType: TextInputType.number,
              labelText: 'Maximális út díj',
              hintText: 'Mennyibe kerüljön maximum?',
              onTapFunction: null,
              icon: Icons.attach_money),
          const SizedBox(
            height: 20.0,
          ),
          CustomTextFieldWithLabel(
              textFieldController: driverNameController,
              inputType: TextInputType.name,
              labelText: 'Sofőr neve',
              hintText: 'A sofőr neve vagy felhasználóneve',
              onTapFunction: null,
              icon: Icons.person),
          const SizedBox(
            height: 20.0,
          ),
          CustomDropdownWithLabel(
            placeHolderText: 'Állatok szállítása',
            labelText: 'Állatok szállítása',
            data: widget.searchData.search.canTransportPets,
            func: (value) {
              widget.searchData.search.canTransportPets =
                  value['value'] as bool?;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomDropdownWithLabel(
            placeHolderText: 'Kerékpárszállítás',
            labelText: 'Kerékpárszállítás',
            data: widget.searchData.search.canTransportBicycle,
            func: (value) {
              widget.searchData.search.canTransportBicycle =
                  value['value'] as bool?;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomDropdownWithLabel(
            placeHolderText: 'Autópálya',
            labelText: 'Autópálya',
            data: widget.searchData.search.isGoingHighway,
            func: (value) {
              widget.searchData.search.isGoingHighway = value['value'] as bool?;
            },
          ),
        ],
      ),
    );
  }
}
