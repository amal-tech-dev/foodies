import 'package:flutter/material.dart';

class EmailLoginController with ChangeNotifier {
  bool isEmailPressed = false;

  showTextFields() {
    isEmailPressed = true;
    notifyListeners();
  }
}
