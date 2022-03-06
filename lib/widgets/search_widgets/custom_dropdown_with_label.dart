import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';

class CustomDropdownWithLabel extends StatelessWidget {
  CustomDropdownWithLabel({
    required this.placeHolderText,
    required this.labelText,
    required this.data,
    required this.func,
    Key? key,
  }) : super(key: key);

  final List dropdownItemList = [
    {'label': 'Igen', 'value': true},
    {'label': 'Nem', 'value': false},
    {'label': 'Nem számít', 'value': null},
  ];

  final String placeHolderText;
  final String labelText;
  final bool? data;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CoolDropdown(
          resultWidth: double.infinity,
          placeholder: placeHolderText,
          defaultValue: data,
          placeholderTS: TextStyle(
            color: Colors.grey.withOpacity(0.7),
            fontSize: 16,
          ),
          resultTS: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          dropdownList: dropdownItemList,
          isResultLabel: true,
          isDropdownLabel: true,
          onChange: func,
          dropdownItemReverse: true,
          dropdownItemMainAxis: MainAxisAlignment.start,
          dropdownHeight: 200,
          resultMainAxis: MainAxisAlignment.start,
          dropdownWidth: 200,
          labelIconGap: 20,
          resultIcon: const Icon(
            Icons.arrow_downward,
          ),
          resultBD: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero,
            border: Border.all(
              color: Colors.black,
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
