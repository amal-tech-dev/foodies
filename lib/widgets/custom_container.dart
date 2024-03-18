import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomContainer extends StatelessWidget {
  double? paddingTop, paddingLeft, paddingRight, paddingBottom, borderRadius;
  bool? border;
  Color? backgroundColor;
  VoidCallback? onPressed;
  Widget child;

  CustomContainer({
    super.key,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        padding: EdgeInsets.only(
          top: paddingTop ?? DimenConstant.padding,
          left: paddingLeft ?? DimenConstant.padding,
          right: paddingRight ?? DimenConstant.padding,
          bottom: paddingBottom ?? DimenConstant.padding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorConstant.tertiary,
          borderRadius: BorderRadius.circular(
            borderRadius ?? DimenConstant.borderRadius,
          ),
          border: border ?? false
              ? Border.all(
                  color: ColorConstant.secondary,
                  width: DimenConstant.borderWidth,
                )
              : Border.all(
                  width: 0.0,
                ),
        ),
        child: child,
      ),
    );
  }
}
