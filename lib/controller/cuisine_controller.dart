import 'package:flutter/material.dart';

class CuisineController with ChangeNotifier {
  List<int> cuisineIndexes = [];

  // add index to list
  addIndex(int index) {
    cuisineIndexes.add(index);
    notifyListeners();
  }

  // delete index from list
  deleteIndex(int index) {
    cuisineIndexes.remove(index);
    notifyListeners();
  }
}
