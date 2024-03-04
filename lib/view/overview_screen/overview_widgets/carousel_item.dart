import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class CarouselItem extends StatelessWidget {
  String title, subtitle;

  CarouselItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.large,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        DimenConstant.separator,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenConstant.padding * 3,
          ),
          child: Text(
            subtitle,
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.extraSmall,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
