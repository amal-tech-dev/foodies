import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';

class SettingsTile extends StatelessWidget {
  IconData icon;
  String header;
  VoidCallback onPressed;
  bool visible;
  Color color;
  SettingsTile({
    super.key,
    required this.icon,
    required this.header,
    required this.onPressed,
    this.visible = true,
    this.color = ColorConstant.secondaryLight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      visible: visible,
      paddingLeft: DimenConstant.padding * 2,
      paddingRight: DimenConstant.padding * 2,
      onPressed: onPressed,
      child: Row(
        children: [
          CustomIcon(icon: icon),
          Separator(),
          CustomText(
            text: header,
            color: color,
            size: DimenConstant.mText,
          ),
        ],
      ),
    );
  }
}
