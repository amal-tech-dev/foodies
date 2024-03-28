import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomButton {
  static Widget elevated({
    required VoidCallback onPressed,
    required Widget child,
    bool? visible,
    Color? background,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              background ?? ColorConstant.secondaryDark,
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: DimenConstant.padding * 2,
              ),
            ),
          ),
          onPressed: onPressed,
          child: child,
        ),
      );

  static Widget text({
    required String text,
    required VoidCallback onPressed,
    bool? visible,
    Color? textColor,
    double? textSize,
    Color? background,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              background ?? ColorConstant.secondaryDark,
            ),
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(
                horizontal: DimenConstant.padding * 3,
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? ColorConstant.tertiaryDark,
              fontSize: textSize ?? DimenConstant.mini,
            ),
          ),
        ),
      );

  static Widget icon({
    required IconData icon,
    required VoidCallback onPressed,
    bool? visible,
    Color? iconColor,
    Color? background,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              background ?? ColorConstant.secondaryDark,
            ),
          ),
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: iconColor ?? ColorConstant.tertiaryDark,
          ),
        ),
      );

  static Widget back({
    Color? iconColor,
    Color? background,
  }) =>
      BackButton(
        color: iconColor ?? ColorConstant.primaryDark,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            background ?? Colors.transparent,
          ),
        ),
      );
}
