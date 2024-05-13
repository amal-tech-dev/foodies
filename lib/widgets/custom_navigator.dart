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

  static Future pushReplacement({
    required BuildContext context,
    required Widget replace,
  }) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => replace,
        ),
      );

  static Future pushAndRemoveUntil({
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
