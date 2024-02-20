import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

class GuestTile extends StatelessWidget {
  GuestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: DimenConstant.padding * 3,
        horizontal: DimenConstant.padding * 2,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.tertiaryColor,
        borderRadius: BorderRadius.circular(
          DimenConstant.borderRadius * 2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              ImageConstant.profile,
            ),
          ),
          DimenConstant.separator,
          Text(
            'Guest',
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.mediumText,
            ),
          ),
        ],
      ),
    );
  }
}
