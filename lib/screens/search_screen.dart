import 'package:collabcar/providers/history_provider.dart';
import 'package:collabcar/providers/logged_user_provider.dart';
import 'package:collabcar/screens/login_screen.dart';
import 'package:collabcar/widgets/search_widgets/stepone_search.dart';
import 'package:collabcar/widgets/search_widgets/stepper_buttons.dart';
import 'package:collabcar/widgets/search_widgets/steptwo_search.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/search_provider.dart';

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
    final searchData = Provider.of<SearchProvider>(context);
    final historyData = Provider.of<HistoryProvider>(context);

    return Theme(
      data: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
          canvasColor: Theme.of(context).canvasColor,
          cardColor: Theme.of(context).cardColor,
          colorScheme:
              ColorScheme.light(primary: Theme.of(context).primaryColor)),
      child: Stepper(
        controlsBuilder: (context, details) {
          return StepperButtons(
            onStepContinue: details.onStepContinue,
            onStepCancel: details.onStepCancel,
            searchData: searchData,
            historyData: historyData,
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
            content: StepOneSearch(
              searchData: searchData,
            ),
            isActive: _currentStep == 0,
          ),
          Step(
            title: const Text("További részletek"),
            content: StepTwoSearch(
              searchData: searchData,
            ),
            isActive: _currentStep == 1,
          ),
        ],
      ),
    );
  }
}
