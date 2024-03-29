import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomSnackBar {
  static ScaffoldFeatureController snackBar({
    required BuildContext context,
    required String content,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstant.tertiaryDark,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(
          DimenConstant.padding,
        ),
        content: Text(
          content,
          style: TextStyle(
            color: ColorConstant.primaryDark,
            fontSize: DimenConstant.mini,
          ),
        ),
      ),
    );
  }
}
