import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';

class Loading extends StatelessWidget {
  bool visible;
  double size, width;

  Loading({
    super.key,
    required this.visible,
    required this.size,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: ColorConstant.secondary,
          strokeWidth: width,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
