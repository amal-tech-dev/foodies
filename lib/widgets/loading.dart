import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class Loading extends StatelessWidget {
  double size, stroke;
  bool? visible;
  double? padding;
  Color? color;

  Loading({
    super.key,
    required this.size,
    required this.stroke,
    this.visible,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: CircularProgressIndicator(
            color: color ?? ColorConstant.primary,
            strokeWidth: stroke,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
