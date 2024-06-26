import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityController with ChangeNotifier {
  bool connected = true;

  // check internet connectivity
  checkConnectivity() async {
    List<ConnectivityResult> connectivity =
        await Connectivity().checkConnectivity();
    connected = connectivity.contains(ConnectivityResult.mobile) ||
            connectivity.contains(ConnectivityResult.wifi)
        ? true
        : false;
    notifyListeners();
  }
}
