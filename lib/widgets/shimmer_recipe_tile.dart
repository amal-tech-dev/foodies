import 'package:flutter/material.dart';
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
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 25,
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: ColorConstant.primary,
                  borderRadius: BorderRadius.circular(
                    DimenConstant.borderRadius * 2,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorConstant.primary,
            ),
          ),
        ],
      ),
    );
  }
}
