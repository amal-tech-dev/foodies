import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class PantryItem extends StatelessWidget {
  String item;
  bool isChecking, isChecked;
  PantryItem({
    super.key,
    required this.item,
    required this.isChecking,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isChecking || isChecked ? 1 : 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(context).size.width * (isChecking ? 0 : 0.1),
        ),
        child: Container(
          padding: EdgeInsets.all(
            DimenConstant.padding,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
            border: Border.all(
              color:
                  isChecked ? ColorConstant.secondaryColor : Colors.transparent,
              width: DimenConstant.borderWidth,
            ),
          ),
          child: Center(
            child: Text(
              item,
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: isChecking
                    ? DimenConstant.mediumText
                    : DimenConstant.miniText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
