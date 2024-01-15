import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

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
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DimenConstant.edgePadding * 2,
        ),
        decoration: BoxDecoration(
          color: isPressed
              ? ColorConstant.secondaryColor
              : ColorConstant.tertiaryColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: isPressed
                  ? ColorConstant.tertiaryColor
                  : ColorConstant.primaryColor,
              fontSize: DimenConstant.extraSmallText,
            ),
          ),
        ),
      ),
    );
  }
}
