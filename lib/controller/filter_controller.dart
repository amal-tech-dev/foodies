import 'package:flutter/material.dart';

class FilterController with ChangeNotifier {
  List<String> filters = [];

  // add filters
  setFilters(List<String> selectedFilters) {
    filters = selectedFilters;
    notifyListeners();
  }

  // remove particular filters
  removeFilter(String filter) {
    filters.remove(filter);
    notifyListeners();
  }

  // remove all filters
  resetFilters() {
    filters = [];
    notifyListeners();
  }
}
