import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class SettingsTile extends StatelessWidget {
  String name;
  Widget screen;
  SettingsTile({
    super.key,
    required this.name,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          DimenConstant.edgePadding * 1.5,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.tertiaryColor,
          borderRadius: BorderRadius.circular(
            DimenConstant.borderRadius,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.subtitleText,
          ),
        ),
      ),
    );
  }
}
