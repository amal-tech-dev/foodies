import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';

class CustomDialog extends StatelessWidget {
  String title, positiveText, negativeText;
  VoidCallback onPositivePressed;
  String? content;
  Widget? contentWidget;
  double? padding, paddingVertical, paddingHorizontal;
  double? paddingTop, paddingLeft, paddingRight, paddingBottom;
  Color positiveColor, negativeColor;
  VoidCallback? onNegativePressed;

  CustomDialog({
    super.key,
    required this.title,
    required this.positiveText,
    required this.onPositivePressed,
    this.content,
    this.contentWidget,
    this.negativeText = 'Cancel',
    this.padding,
    this.paddingVertical,
    this.paddingHorizontal,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.positiveColor = ColorConstant.primary,
    this.negativeColor = ColorConstant.secondaryLight,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConstant.backgroundLight,
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
        size: DimenConstant.small,
      ),
      content: contentWidget ??
          CustomText(
            text: content ?? '',
            color: ColorConstant.secondaryLight,
            size: DimenConstant.xSmall,
            align: TextAlign.justify,
          ),
      actions: [
        CustomText(
          text: negativeText,
          color: negativeColor,
          size: DimenConstant.xSmall,
          onPressed: onNegativePressed ?? () => Navigator.pop(context),
        ),
        Separator(),
        CustomText(
          text: positiveText,
          color: positiveColor,
          size: DimenConstant.xSmall,
          onPressed: onPositivePressed,
        ),
      ],
    );
  }
}
