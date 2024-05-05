import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';

class CustomDialog extends StatelessWidget {
  String title, positiveText;
  VoidCallback onPositivePressed;
  String? content, negativeText;
  Widget? contentWidget;
  double? padding, paddingVertical, paddingHorizontal;
  double? paddingTop, paddingLeft, paddingRight, paddingBottom;
  Color? positiveColor, negativeColor;
  VoidCallback? onNegativePressed;

  CustomDialog({
    super.key,
    required this.title,
    required this.positiveText,
    required this.onPositivePressed,
    this.content,
    this.contentWidget,
    this.negativeText,
    this.padding,
    this.paddingVertical,
    this.paddingHorizontal,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.positiveColor,
    this.negativeColor,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.backgroundDark,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.only(
        top: padding ??
            paddingVertical ??
            paddingTop ??
            DimenConstant.padding * 2.5,
        left: padding ??
            paddingHorizontal ??
            paddingLeft ??
            DimenConstant.padding * 2.5,
        right: padding ??
            paddingHorizontal ??
            paddingRight ??
            DimenConstant.padding * 2.5,
        bottom: padding ??
            paddingVertical ??
            paddingBottom ??
            DimenConstant.padding * 2.5,
      ),
      title: CustomText(
        text: title,
        color: ColorConstant.primary,
        size: DimenConstant.sText,
      ),
      content: contentWidget ??
          CustomText(
            text: content ?? '',
            color: ColorConstant.secondaryDark,
            size: DimenConstant.xsText,
            align: TextAlign.justify,
          ),
      actions: [
        CustomText(
          text: negativeText ?? 'Cancel',
          color: negativeColor ?? ColorConstant.secondaryDark,
          size: DimenConstant.xsText,
          onPressed: onNegativePressed ?? () => Navigator.pop(context),
        ),
        Separator(),
        CustomText(
          text: positiveText,
          color: positiveColor ?? ColorConstant.primary,
          size: DimenConstant.xsText,
          onPressed: onPositivePressed,
        ),
      ],
    );
  }
}
