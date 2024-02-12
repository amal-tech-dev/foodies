import 'package:flutter/material.dart';

class FilterController with ChangeNotifier {
  List<String> filters = [];

  // add filters
  setFilters(List selectedFilters) {
    notifyListeners();
  }

  // remove filters
  resetFilters(String diet, List cuisines, List categories) {
    notifyListeners();
  }
}
