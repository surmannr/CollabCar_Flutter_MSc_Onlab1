import 'package:flutter/material.dart';

class CustomTextFieldWithLabel extends StatelessWidget {
  final TextEditingController textFieldController;
  final String labelText;
  final String hintText;
  final VoidCallback? onTapFunction;
  final TextInputType inputType;
  final IconData icon;

  const CustomTextFieldWithLabel({
    required this.textFieldController,
    required this.labelText,
    required this.hintText,
    required this.onTapFunction,
    required this.inputType,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        label: Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 138, 211, 140),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.8, color: Colors.black),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: Color.fromARGB(255, 138, 211, 140)),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 138, 211, 140),
        ),
      ),
      onTap: onTapFunction,
    );
  }
}
