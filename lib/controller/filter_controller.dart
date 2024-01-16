import 'package:flutter/material.dart';

class FilterController with ChangeNotifier {
  String filteredDiet = '';
  List filteredCusines = [];
  List filteredCategories = [];
  bool isFiltersUsed = false;

  // add filters
  setFilters(String? diet, List? cuisines, List? categories) {
    isFiltersUsed = true;
    notifyListeners();
  }

  // remove filters
  resetFilters(String diet, List cuisines, List categories) {
    isFiltersUsed = false;
    initializeFilters(diet, cuisines, categories);
    notifyListeners();
  }

  // initialize filters with pre-defined data
  initializeFilters(String diet, List cuisines, List categories) {
    filteredDiet = diet;
    filteredCusines = cuisines;
    filteredCategories = categories;
    notifyListeners();
  }
}
