import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;
  Color color;
  double size;
  FontWeight? weight;
  String? family;
  TextAlign? align;
  bool? visible;
  VoidCallback? onPressed;

  CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    this.weight,
    this.family,
    this.align,
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
            color: color,
            fontSize: size,
            fontWeight: weight ?? FontWeight.normal,
            fontFamily: family,
          ),
          textAlign: align ?? TextAlign.start,
        ),
      ),
    );
  }
}
