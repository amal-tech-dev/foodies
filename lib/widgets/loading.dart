import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class Loading extends StatelessWidget {
  double size, stroke;
  bool visible;
  double padding;
  Color color;

  Loading({
    super.key,
    required this.size,
    required this.stroke,
    this.visible=true,
    this.padding=0,
    this.color=ColorConstant.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: CircularProgressIndicator(
            color: color ,
            strokeWidth: stroke,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }
}
