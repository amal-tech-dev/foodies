import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

class FilterItem extends StatelessWidget {
  String name;
  bool isPressed;
  VoidCallback onPressed;

  FilterItem({
    super.key,
    required this.name,
    required this.isPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      paddingLeft: DimenConstant.padding * 2.0,
      paddingRight: DimenConstant.padding * 2.0,
      borderRadius: 100.0,
      color: isPressed ? ColorConstant.primary : ColorConstant.secondaryLight,
      onPressed: onPressed,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: isPressed
                ? ColorConstant.tertiaryLight
                : ColorConstant.secondaryLight,
            fontSize: DimenConstant.xxSmall,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
