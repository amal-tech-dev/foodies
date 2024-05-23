import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class FoodiesTheme {
  static ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
      color: ColorConstant.backgroundLight,
      surfaceTintColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: ColorConstant.backgroundLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorConstant.primary,
      selectionColor: ColorConstant.primary.withOpacity(0.5),
      selectionHandleColor: ColorConstant.primary,
    ),
  );

  static ThemeData dark = ThemeData(
    appBarTheme: const AppBarTheme(
      color: ColorConstant.backgroundDark,
      surfaceTintColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: ColorConstant.backgroundDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorConstant.primary,
      selectionColor: ColorConstant.primary.withOpacity(0.5),
      selectionHandleColor: ColorConstant.primary,
    ),
  );
}
