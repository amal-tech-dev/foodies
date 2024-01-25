import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderController with ChangeNotifier {
  CarouselController controller = CarouselController();

  // go to previous page on carousel slider
  previousPage() {
    controller.previousPage();
    notifyListeners();
  }

  // go to next page on carousel slider
  nextPage() {
    controller.nextPage();
    notifyListeners();
  }
}
