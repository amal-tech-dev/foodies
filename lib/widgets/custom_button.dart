import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';

class CustomButton {
  static Widget elevated({
    required VoidCallback onPressed,
    required Widget child,
    bool visible = true,
    Color background = ColorConstant.primary,
  }) {
    return Visibility(
      visible: visible,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(background),
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
  }

  static Widget text({
    required String text,
    required VoidCallback onPressed,
    bool visible = true,
    Color textColor = ColorConstant.tertiaryLight,
    double textSize = DimenConstant.xsText,
    Color background = ColorConstant.primary,
  }) {
    return Visibility(
      visible: visible ?? true,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(background),
          padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: DimenConstant.padding * 3,
            ),
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          text: text,
          color: textColor,
          size: textSize,
        ),
      ),
    );
  }

  static Widget icon({
    required IconData icon,
    required VoidCallback onPressed,
    bool visible = true,
    Color iconColor = ColorConstant.tertiaryLight,
    Color background = Colors.transparent,
  }) {
    return Visibility(
      visible: visible ?? true,
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(background),
        ),
        onPressed: onPressed,
        icon: CustomIcon(
          icon: icon,
          color: iconColor,
        ),
      ),
    );
  }

  static Widget back({
    Color iconColor = ColorConstant.secondaryLight,
    Color background = Colors.transparent,
    VoidCallback? onPressed,
  }) {
    return BackButton(
      color: iconColor,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(background),
      ),
      onPressed: onPressed,
    );
  }
}
