import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';

class Separator extends StatelessWidget {
  bool? visible;
  double? height, width;

  Separator({
    super.key,
    this.visible,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: SizedBox(
        height: height ?? DimenConstant.padding,
        width: width ?? DimenConstant.padding,
      ),
    );
  }
}
