import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class FoodiesTheme {
  static ThemeData light = ThemeData(
    appBarTheme: const AppBarTheme(
      color: ColorConstant.backgroundLight,
      surfaceTintColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: ColorConstant.backgroundLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConstant.backgroundLight,
      selectedItemColor: ColorConstant.primary,
      unselectedItemColor: ColorConstant.secondaryLight,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    ),
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
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorConstant.backgroundDark,
      selectedItemColor: ColorConstant.primary,
      unselectedItemColor: ColorConstant.secondaryDark,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorConstant.primary,
      selectionColor: ColorConstant.primary.withOpacity(0.5),
      selectionHandleColor: ColorConstant.primary,
    ),
  );
}
