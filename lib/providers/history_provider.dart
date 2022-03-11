import 'dart:convert';

import 'package:collabcar/models/histories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/search.dart';

class HistoryProvider with ChangeNotifier {
  Histories _histories = Histories(searches: []);
  final String historyKey = "historyList";

  Histories get histories {
    return _histories;
  }

  Future<Histories> getFromDevice() async {
    final sharedPref = await SharedPreferences.getInstance();
    final listJson = sharedPref.getString(historyKey) ?? "{}";

    final list = Histories.fromJson(jsonDecode(listJson));
    _histories = list;

    return _histories;
  }

  void addNewHistoryElement(Search search) async {
    _histories.searches.add(search);
    final historyString = jsonEncode(_histories.toJson());

    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(historyKey);
    sharedPref.setString(historyKey, historyString);
    notifyListeners();
  }

  void deleteHistoryElement(String id) async {
    _histories.searches.removeWhere((element) => element.id == id);
    final historyString = jsonEncode(_histories.toJson());

    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(historyKey);
    sharedPref.setString(historyKey, historyString);
    notifyListeners();
  }
}
