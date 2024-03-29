import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRecipeTile extends StatelessWidget {
  ShimmerRecipeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerTertiary,
          ColorConstant.shimmerSecondary,
          ColorConstant.shimmerPrimary,
          ColorConstant.shimmerPrimary,
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryDark,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadiusLarge,
                    ),
                  ),
                ),
                DimenConstant.separator,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      color: ColorConstant.primaryDark,
                    ),
                    Icon(
                      Icons.visibility_rounded,
                      color: ColorConstant.primaryDark,
                    ),
                    FaIcon(
                      FontAwesomeIcons.share,
                      color: ColorConstant.primaryDark,
                      size: 18,
                    ),
                    Icon(
                      Icons.bookmark_rounded,
                    ),
                  ],
                ),
                DimenConstant.separator,
              ],
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorConstant.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
