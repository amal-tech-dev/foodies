import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

class StepItem extends StatelessWidget {
  String item;
  bool cooking, completed;
  StepItem({
    super.key,
    required this.item,
    required this.cooking,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.padding,
      ),
      child: CustomContainer(
        paddingTop: DimenConstant.padding * 2,
        paddingLeft: DimenConstant.padding * 2,
        paddingRight: DimenConstant.padding * 2,
        paddingBottom: DimenConstant.padding * 2,
        borderRadius: DimenConstant.borderRadiusLarge,
        child: Center(
          child: Text(
            item,
            style: TextStyle(
              color: ColorConstant.secondaryLight,
              fontSize: DimenConstant.mText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
