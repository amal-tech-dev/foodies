import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          ColorConstant.shimmerPrimaryGradient,
          ColorConstant.shimmerSecondaryGradient,
          ColorConstant.shimmerTertiaryGradient,
          ColorConstant.shimmerSecondaryGradient,
          ColorConstant.shimmerPrimaryGradient,
          ColorConstant.shimmerPrimaryGradient,
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: ColorConstant.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: ColorConstant.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
