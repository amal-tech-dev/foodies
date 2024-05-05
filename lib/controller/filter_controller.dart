import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterController with ChangeNotifier {
  List<String> filters = [], diet = [], cuisines = [], categories = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get diet from firestore
  getDiet() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('diet').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    diet = List<String>.from(data['diet']);
  }

  // get cuisine from firestore
  getCuisines() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('cuisines').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cuisines = List<String>.from(data['cuisines']);
  }

  // get categories from firestore
  getCategories() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('categories').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    categories = List<String>.from(data['categories']);
  }

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
