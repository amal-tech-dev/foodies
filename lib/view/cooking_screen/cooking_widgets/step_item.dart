import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class StepItem extends StatelessWidget {
  String item;
  bool isCooking, isCompleted;
  StepItem({
    super.key,
    required this.item,
    required this.isCooking,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      child: Container(
        padding: EdgeInsets.all(
          DimenConstant.edgePadding * 2,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.tertiaryColor,
          borderRadius: BorderRadius.circular(
            DimenConstant.borderRadius * 2,
          ),
        ),
        child: Center(
          child: Text(
            item,
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
