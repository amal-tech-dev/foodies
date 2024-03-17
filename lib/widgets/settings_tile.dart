import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/madroid.dart';

class SettingsTile extends StatelessWidget {
  IconData icon;
  String header;
  VoidCallback onPressed;
  Color? color;
  SettingsTile({
    super.key,
    required this.icon,
    required this.header,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Madroid.container(
      paddingLeft: DimenConstant.padding * 2,
      paddingRight: DimenConstant.padding * 2,
      child: Row(
        children: [
          Icon(
            icon,
            color: ColorConstant.primary,
          ),
          DimenConstant.separator,
          Text(
            header,
            style: TextStyle(
              color: color ?? ColorConstant.secondary,
              fontSize: DimenConstant.small,
            ),
          ),
        ],
      ),
    );
  }
}
