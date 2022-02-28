import 'package:flutter/material.dart';

class StepperButtons extends StatelessWidget {
  const StepperButtons(
      {this.onStepContinue,
      this.onStepCancel,
      required this.firstStep,
      required this.secondStep,
      Key? key})
      : super(key: key);

  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;

  final bool firstStep;
  final bool secondStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (!secondStep)
          TextButton(
            onPressed: onStepContinue,
            child: const Text('Következő'),
          ),
        if (secondStep)
          TextButton(
            onPressed: () => print("he"),
            child: const Text('Keresés'),
          ),
        if (!firstStep)
          TextButton(
            onPressed: onStepCancel,
            child: const Text('Vissza'),
          ),
      ],
    );
  }
}
