import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CustomScrollbar extends StatelessWidget {
  CustomScrollbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 2.5,
      decoration: BoxDecoration(
        color: ColorConstant.secondaryDark,
        borderRadius: BorderRadius.circular(
          DimenConstant.borderRadiusLarge,
        ),
      ),
    );
  }
}
