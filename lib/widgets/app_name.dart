import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class AppName extends StatelessWidget {
  double size;
  bool? bold;

  AppName({
    super.key,
    required this.size,
    this.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringConstant.appNamePrefix,
          style: TextStyle(
            color: ColorConstant.primaryDark,
            fontSize: size,
            fontWeight: bold ?? false ? FontWeight.bold : FontWeight.normal,
            fontFamily: StringConstant.font,
          ),
        ),
        Text(
          StringConstant.appNameSuffix,
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: size,
            fontFamily: StringConstant.font,
          ),
        ),
      ],
    );
  }
}
