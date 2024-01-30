import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class ProfileTile extends StatelessWidget {
  String username, name, image;
  ProfileTile({
    super.key,
    required this.username,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DimenConstant.edgePadding * 2,
          horizontal: DimenConstant.edgePadding,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                image,
              ),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '@${username}',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
