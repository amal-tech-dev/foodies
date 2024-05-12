import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/separator.dart';

class CarouselItem extends StatelessWidget {
  String title, subtitle;

  CarouselItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: DimenConstant.borderRadiusSmall * 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.xlText,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Separator(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding * 3,
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                color: ColorConstant.secondaryLight,
                fontSize: DimenConstant.sText,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
