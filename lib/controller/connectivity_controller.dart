import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController with ChangeNotifier {
  bool isConnected = true;

  // check internet connectivity
  checkConnectivity() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none)
      isConnected = false;
    else
      isConnected = true;
    notifyListeners();
  }
}