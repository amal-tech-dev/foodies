import 'package:flutter/material.dart';

class CarouselSliderController with ChangeNotifier {
  int index = 0;

  // increment index
  increment() {
    index++;
    notifyListeners();
  }
}
