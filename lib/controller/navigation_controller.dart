import 'package:flutter/material.dart';

class NavigationController with ChangeNotifier {
  bool isVisible = false;
  bool isFirstVisit = true;
  bool isLoggedIn = false;

  // show loading indicator till data is fetched
  startLoading() {
    isVisible = true;
    notifyListeners();
  }

  // stop loading indicator after data is fetched
  stopLoading() {
    isVisible = false;
    notifyListeners();
  }

  // check is it first time
  closeOverview() {
    isFirstVisit = false;
    notifyListeners();
  }

  // check is logged in
  loggedIn() {
    isLoggedIn = true;
    notifyListeners();
  }

  // check is logged out
  loggedOut() {
    isLoggedIn = false;
    notifyListeners();
  }
}
