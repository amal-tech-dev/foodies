import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderController with ChangeNotifier {
  CarouselController controller = CarouselController();
  PageController indicator = PageController();

  // go to previous page on carousel slider
  previousPage() {
    controller.previousPage();
    indicator.previousPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  // go to next page on carousel slider
  nextPage() {
    controller.nextPage();
    indicator.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
