import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class FoodiesButton {
  static Widget button({
    required VoidCallback onPressed,
    required Widget child,
    Color? background,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget text({
    required VoidCallback onPressed,
    required String text,
    Color? background,
    Color? textColor,
  }) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? ColorConstant.tertiary,
          fontSize: DimenConstant.mini,
        ),
      ),
    );
  }

  static Widget icon({
    required VoidCallback onPressed,
    required IconData icon,
    Color? background,
    Color? iconColor,
  }) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor ?? ColorConstant.tertiary,
      ),
    );
  }

  static Widget back({
    Color? background,
    Color? iconColor,
  }) {
    return BackButton(
      color: iconColor ?? ColorConstant.primary,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? Colors.transparent,
        ),
      ),
    );
  }
}
