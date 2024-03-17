import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/madroid.dart';

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
        child: Madroid.container(
          border: isChecked,
          child: Center(
            child: Text(
              item,
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize:
                    isChecking ? DimenConstant.medium : DimenConstant.mini,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
