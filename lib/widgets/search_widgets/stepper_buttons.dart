import 'dart:convert';

import 'package:collabcar/providers/history_provider.dart';
import 'package:collabcar/providers/search_provider.dart';
import 'package:flutter/material.dart';

import '../../models/search.dart';

class StepperButtons extends StatelessWidget {
  const StepperButtons(
      {this.onStepContinue,
      this.onStepCancel,
      required this.searchData,
      required this.historyData,
      required this.firstStep,
      required this.secondStep,
      Key? key})
      : super(key: key);

  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;

  final SearchProvider searchData;
  final HistoryProvider historyData;

  final bool firstStep;
  final bool secondStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 15.0,
        ),
        if (!secondStep)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).cardColor)),
              onPressed: onStepContinue,
              child: const Text(
                'Következő',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        if (secondStep)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).cardColor)),
              onPressed: () {
                print(jsonEncode(
                  searchData.search,
                  toEncodable: (nonEncodable) => nonEncodable is Search
                      ? Search.toJson(nonEncodable)
                      : throw Exception('Nem'),
                ));
                historyData.addNewHistoryElement(searchData.search);
                searchData.clearSearch();
              },
              child: const Text(
                'Keresés',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        if (!firstStep)
          SizedBox(
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).cardColor)),
              onPressed: onStepCancel,
              child: const Text(
                'Vissza',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
