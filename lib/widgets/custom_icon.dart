import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class CustomIcon extends StatelessWidget {
  IconData icon;
  bool visible;
  double? size;
  Color? color;
  VoidCallback? onPressed;

  CustomIcon({
    super.key,
    required this.icon,
    this.visible = true,
    this.size,
    this.color = ColorConstant.secondaryLight,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: onPressed,
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
