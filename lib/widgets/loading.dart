import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class Loading extends StatelessWidget {
  bool visible;
  double size, width;
  double? padding;
  Color? color;

  Loading({
    super.key,
    required this.visible,
    required this.size,
    required this.width,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0.0),
          child: CircularProgressIndicator(
            color: color ?? ColorConstant.secondaryDark,
            strokeWidth: width,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
