import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomButton {
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
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
    double? textSize,
    Color? background,
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
          fontSize: textSize ?? DimenConstant.mini,
        ),
      ),
    );
  }

  static Widget icon({
    required IconData icon,
    required VoidCallback onPressed,
    Color? iconColor,
    Color? background,
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
    Color? iconColor,
    Color? background,
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
