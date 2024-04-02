import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_button.dart';

class TimePreview extends StatelessWidget {
  String time;
  VoidCallback onPressed;
  TimePreview({
    super.key,
    required this.time,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Cooking time',
            style: TextStyle(
              color: ColorConstant.secondaryDark,
              fontSize: DimenConstant.medium,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.large,
            ),
          ),
          DimenConstant.separator,
          CustomButton.text(
            text: 'Next',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
