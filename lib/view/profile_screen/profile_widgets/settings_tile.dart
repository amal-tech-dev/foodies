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
      child: Row(
        children: [
          Icon(
            Icons.restaurant_rounded,
            size: 30,
            color: ColorConstant.primaryColor,
          ),
          DimenConstant.separator,
          Text(
            name,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.smallText,
            ),
          ),
        ],
      ),
    );
  }
}
