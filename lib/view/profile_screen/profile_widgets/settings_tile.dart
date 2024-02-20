import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class SettingTile extends StatelessWidget {
  IconData icon;
  String name;
  VoidCallback onPressed;

  SettingTile({
    super.key,
    required this.icon,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(
          DimenConstant.padding,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.tertiaryColor,
          borderRadius: BorderRadius.circular(
            DimenConstant.borderRadius,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorConstant.primaryColor,
            ),
            DimenConstant.separator,
            Text(
              name,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.extraSmallText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
