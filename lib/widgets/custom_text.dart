import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  FontWeight weight;
  String? font;
  TextAlign align;
  int? lines;
  TextOverflow overflow;
  bool visible;
  VoidCallback? onPressed;

  CustomText({
    super.key,
    required this.text,
    this.color = ColorConstant.secondaryLight,
    this.size = DimenConstant.sText,
    this.weight = FontWeight.normal,
    this.font,
    this.align = TextAlign.start,
    this.lines,
    this.overflow = TextOverflow.ellipsis,
    this.visible = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: weight,
            fontFamily: font,
          ),
          textAlign: align,
          maxLines: lines,
          overflow: overflow,
        ),
      ),
    );
  }
}
