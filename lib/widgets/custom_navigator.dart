import 'package:flutter/material.dart';

class CustomNavigator {
  static Future push({
    required BuildContext context,
    required Widget push,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => push,
        ),
      );

  static Future replacement({
    required BuildContext context,
    required Widget replace,
  }) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => replace,
        ),
      );

  static Future removeUntil({
    required BuildContext context,
    required Widget removeUntil,
  }) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => removeUntil,
        ),
        (route) => false,
      );
}
