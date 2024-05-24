import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text.dart';

class FilterItem extends StatelessWidget {
  String name;
  bool pressed;
  VoidCallback onPressed;

  FilterItem({
    super.key,
    required this.name,
    required this.pressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 35,
      paddingHorizontal: DimenConstant.padding * 2.0,
      color: pressed
          ? ColorConstant.primary.withOpacity(0.2)
          : ColorConstant.tertiaryLight,
      border: pressed,
      onPressed: onPressed,
      child: Center(
        child: CustomText(
          text: name,
          color: pressed ? ColorConstant.primary : ColorConstant.secondaryLight,
          size: DimenConstant.xxSmall,
          weight: pressed ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
