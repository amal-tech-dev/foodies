import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class SettingsTile extends StatelessWidget {
  IconData icon;
  String name;
  VoidCallback onPressed;
  Color? color;

  SettingsTile({
    super.key,
    required this.icon,
    required this.name,
    required this.onPressed,
    this.color,
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
            DimenConstant.separator,
            Icon(
              icon,
              color: ColorConstant.primaryColor,
            ),
            DimenConstant.separator,
            Text(
              name,
              style: TextStyle(
                color: color ?? ColorConstant.secondaryColor,
                fontSize: DimenConstant.smallText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
