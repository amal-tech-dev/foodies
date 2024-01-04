import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CuisineTile extends StatelessWidget {
  String name;
  bool isPressed;
  VoidCallback onPressed;
  CuisineTile({
    super.key,
    required this.name,
    required this.isPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.tertiaryColor,
          borderRadius: BorderRadius.circular(
            DimenConstant.borderRadius,
          ),
          border: Border.all(
            color:
                isPressed ? ColorConstant.secondaryColor : Colors.transparent,
            width: DimenConstant.borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.smallText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
