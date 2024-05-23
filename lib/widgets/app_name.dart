import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/custom_text.dart';

class AppName extends StatelessWidget {
  double size;
  FontWeight weight;

  AppName({
    super.key,
    this.size = DimenConstant.medium,
    this.weight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: StringConstant.appNamePrefix,
          size: size,
          weight: weight,
          font: StringConstant.font,
        ),
        CustomText(
          text: StringConstant.appNameSuffix,
          color: ColorConstant.primary,
          size: size,
          weight: weight,
          font: StringConstant.font,
        ),
      ],
    );
  }
}
