import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';

class Separator extends StatelessWidget {
  bool visible;
  double height, width;

  Separator({
    super.key,
    this.visible = true,
    this.height = DimenConstant.padding,
    this.width = DimenConstant.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(height: height, width: width),
    );
  }
}
