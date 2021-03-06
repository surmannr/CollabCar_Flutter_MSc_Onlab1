import 'package:flutter/material.dart';

import 'package:collabcar/models/search.dart';

import '../models/place.dart';

class SearchProvider with ChangeNotifier {
  Search _search = Search(
    date: DateTime.now(),
  );

  Search get search {
    return _search;
  }

  void clearSearch() {
    _search = Search(date: DateTime.now());
  }

  void setPlaceFrom(Place placeFrom) {
    _search.placeFrom = placeFrom;
    notifyListeners();
  }

  void setPlaceTo(Place placeTo) {
    _search.placeTo = placeTo;
    notifyListeners();
  }
}
