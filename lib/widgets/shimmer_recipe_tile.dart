import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_circle_avatar.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRecipeTile extends StatelessWidget {
  ShimmerRecipeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerTertiary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                CustomContainer(
                  height: 150,
                  borderRadius: DimenConstant.borderRadiusLarge,
                ),
                Separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIcon(icon: Icons.favorite_rounded),
                    CustomIcon(icon: Icons.visibility_rounded),
                    FaIcon(FontAwesomeIcons.share, size: 18),
                    CustomIcon(icon: Icons.bookmark_rounded),
                  ],
                ),
                Separator(),
              ],
            ),
          ),
          Positioned(
            left: 20,
            child: CustomCircleAvatar(
              radius: 50,
              color: ColorConstant.secondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
