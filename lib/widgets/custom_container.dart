import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomContainer extends StatelessWidget {
  double? height, width, borderRadius;
  double? padding, paddingVertical, paddingHorizontal;
  double? paddingTop, paddingLeft, paddingRight, paddingBottom;
  bool? border, visible;
  Color? color;
  BoxShape? shape;
  List<Color>? gradients;
  VoidCallback? onPressed;
  Widget? child;

  CustomContainer({
    super.key,
    this.visible,
    this.height,
    this.width,
    this.padding,
    this.paddingVertical,
    this.paddingHorizontal,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.borderRadius,
    this.border,
    this.color,
    this.shape,
    this.gradients,
    this.onPressed,
    this.child,
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
            top: padding ??
                paddingVertical ??
                paddingTop ??
                DimenConstant.padding,
            left: padding ??
                paddingHorizontal ??
                paddingLeft ??
                DimenConstant.padding,
            right: padding ??
                paddingHorizontal ??
                paddingRight ??
                DimenConstant.padding,
            bottom: padding ??
                paddingVertical ??
                paddingBottom ??
                DimenConstant.padding,
          ),
          decoration: BoxDecoration(
            color:
                gradients == null ? color ?? ColorConstant.tertiaryLight : null,
            shape: shape ?? BoxShape.rectangle,
            gradient:
                color == null ? LinearGradient(colors: gradients ?? []) : null,
            borderRadius: BorderRadius.circular(
              borderRadius ?? DimenConstant.borderRadiusSmall,
            ),
            border: border ?? false
                ? Border.all(
                    color: ColorConstant.primary,
                    width: DimenConstant.borderWidth,
                  )
                : Border.all(width: 0.0, color: Colors.transparent),
          ),
          child: child,
        ),
      ),
    );
  }
}
