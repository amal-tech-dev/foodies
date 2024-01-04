import 'package:flutter/material.dart';

class NavigationController with ChangeNotifier {
  bool isFirstVisit = true;
  bool isLoggedin = false;
  bool isFirstLogin = false;

  // check is it first time
  closeOverview() {
    isFirstVisit = false;
    notifyListeners();
  }

  // check is logged in
  loggedIn() {
    isLoggedin = true;
    notifyListeners();
  }

  // check is logged out
  loggedOut() {
    isLoggedin = false;
    notifyListeners();
  }

  // check is it first time login
  closeSelection() {
    isFirstLogin = false;
    notifyListeners();
  }
}
