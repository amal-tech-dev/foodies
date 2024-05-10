import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
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
                    color: ColorConstant.secondaryLight,
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadiusLarge,
                    ),
                  ),
                ),
                Separator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.favorite_rounded),
                    Icon(Icons.visibility_rounded),
                    FaIcon(FontAwesomeIcons.share, size: 18),
                    Icon(Icons.bookmark_rounded),
                  ],
                ),
                Separator(),
              ],
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorConstant.secondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
