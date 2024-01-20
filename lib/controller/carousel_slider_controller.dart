import 'package:flutter/material.dart';

class CarouselSliderController with ChangeNotifier {
  int index = 0;

  // increment index
  increment() {
    index++;
    notifyListeners();
  }

  // decrement index
  decrement() {
    if (index >= 2) index--;
    notifyListeners();
  }
}
