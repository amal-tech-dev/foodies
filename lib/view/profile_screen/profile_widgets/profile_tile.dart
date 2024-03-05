import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

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
    return CustomContainer(
      paddingTop: DimenConstant.padding * 3.0,
      paddingLeft: DimenConstant.padding * 2.0,
      paddingRight: DimenConstant.padding * 2.0,
      paddingBottom: DimenConstant.padding * 3.0,
      borderRadius: DimenConstant.borderRadius * 2.0,
      onPressed: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              ImageConstant.profile,
            ),
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
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.medium,
                ),
              ),
              Text(
                '@${username}',
                style: TextStyle(
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.extraSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
