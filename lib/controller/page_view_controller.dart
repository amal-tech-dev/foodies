import 'package:flutter/material.dart';

class PageViewController with ChangeNotifier {
  PageController controller = PageController();

  // go to previous page on carousel slider
  previousPage() {
    controller.previousPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  // go to next page on carousel slider
  nextPage() {
    controller.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }
}
