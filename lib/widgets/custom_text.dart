import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomText extends StatelessWidget {
  String text;
  Color? color;
  double? size;
  FontWeight? weight;
  String? font;
  TextAlign? align;
  int? lines;
  TextOverflow? overflow;
  bool? visible;
  VoidCallback? onPressed;

  CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.font,
    this.align,
    this.lines,
    this.overflow,
    this.visible,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color ?? ColorConstant.secondaryLight,
            fontSize: size ?? DimenConstant.sText,
            fontWeight: weight ?? FontWeight.normal,
            fontFamily: font,
          ),
          textAlign: align ?? TextAlign.start,
          maxLines: lines,
          overflow: overflow ?? TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
