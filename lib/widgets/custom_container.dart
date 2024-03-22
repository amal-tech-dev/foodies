import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomContainer extends StatelessWidget {
  double? height, width, borderRadius;
  double? paddingTop, paddingLeft, paddingRight, paddingBottom;
  bool? border, visible;
  Color? backgroundColor;
  Gradient? gradient;
  VoidCallback? onPressed;
  Widget child;

  CustomContainer({
    super.key,
    this.visible,
    this.height,
    this.width,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.gradient,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
            top: paddingTop ?? DimenConstant.padding,
            left: paddingLeft ?? DimenConstant.padding,
            right: paddingRight ?? DimenConstant.padding,
            bottom: paddingBottom ?? DimenConstant.padding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorConstant.tertiary,
            gradient: gradient,
            borderRadius: BorderRadius.circular(
              borderRadius ?? DimenConstant.borderRadiusSmall,
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
      ),
    );
  }
}
