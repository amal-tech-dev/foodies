import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

class ProfileTile extends StatelessWidget {
  String name, username;
  String? image;
  VoidCallback onPressed;

  ProfileTile({
    super.key,
    required this.name,
    required this.username,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
              radius: 50,backgroundImage:AssetImage(
              ImageConstant.profile,
            ) ,
              foregroundImage: image != null
                  ? NetworkImage(
                      image!,
                    )
                  : AssetImage(
                      ImageConstant.profile,
                    ) as ImageProvider<Object>,
            ),
            DimenConstant.separator,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.mediumText,
                  ),
                ),
                Text(
                  '@${username}',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
