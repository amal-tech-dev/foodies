import 'package:flutter/material.dart';
import 'package:foodies/main.dart';

class FilterController with ChangeNotifier {
  Diet filteredDiet = Diet.semi;
  List filteredCusines = [];
  List filteredCategories = [];
  bool isFiltersUsed = false;

  // add filters
  setFilters(Diet? diet, List? cuisines, List? categories) {
    isFiltersUsed = true;
    notifyListeners();
  }

  // remove filters
  resetFilters(Diet diet, List cuisines, List categories) {
    isFiltersUsed = false;
    initializeFilters(diet, cuisines, categories);
    notifyListeners();
  }

  // initialize filters with pre-defined data
  initializeFilters(Diet diet, List cuisines, List categories) {
    filteredDiet = diet;
    filteredCusines = cuisines;
    filteredCategories = categories;
    notifyListeners();
  }
}
