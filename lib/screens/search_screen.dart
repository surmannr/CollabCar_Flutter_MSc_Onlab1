import 'package:collabcar/widgets/search_widgets/stepone_search.dart';
import 'package:collabcar/widgets/search_widgets/stepper_buttons.dart';
import 'package:collabcar/widgets/search_widgets/steptwo_search.dart';
import 'package:flutter/material.dart';

import 'package:collabcar/widgets/menu/main_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _currentStep = 0;
  final int _maxStepIndex = 1;

  // Ha magára a lépésre kattintunk akkor az állítódjon be.
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  // A lépés alján lévő következő gomb funkciója, továbblép a következőre.
  _stepContinue() {
    _currentStep < _maxStepIndex ? setState(() => _currentStep += 1) : null;
  }

  // A lépés alján lévő vissza gomb funkciója, visszalép az előzőre.
  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CollabCar'),
      ),
      drawer: const MainDrawer(),
      body: Stepper(
        controlsBuilder: (context, details) {
          return StepperButtons(
            onStepContinue: details.onStepContinue,
            onStepCancel: details.onStepCancel,
            firstStep: _currentStep == 0,
            secondStep: _currentStep == _maxStepIndex,
          );
        },
        type: StepperType.horizontal,
        elevation: 0.6,
        currentStep: _currentStep,
        onStepTapped: (step) => _stepTapped(step),
        onStepContinue: _stepContinue,
        onStepCancel: _stepCancel,
        steps: [
          Step(
            title: const Text("Keresés"),
            content: const StepOneSearch(),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text("További részletek"),
            content: const StepTwoSearch(),
            isActive: _currentStep == 1,
          ),
        ],
      ),
    );
  }
}
