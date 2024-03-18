import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/foodies_widget.dart';

class GuestTile extends StatelessWidget {
  GuestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return FoodiesWidget.container(
      paddingTop: DimenConstant.padding * 3.0,
      paddingLeft: DimenConstant.padding * 2.0,
      paddingRight: DimenConstant.padding * 2.0,
      paddingBottom: DimenConstant.padding * 3.0,
      borderRadius: DimenConstant.borderRadius * 2.0,
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
              color: ColorConstant.primary,
              fontSize: DimenConstant.medium,
            ),
          ),
        ],
      ),
    );
  }
}
