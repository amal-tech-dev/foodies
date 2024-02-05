import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

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
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.mediumText,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.largeText,
            ),
          ),
          DimenConstant.separator,
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                ColorConstant.secondaryColor,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              'Next',
              style: TextStyle(
                color: ColorConstant.tertiaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
