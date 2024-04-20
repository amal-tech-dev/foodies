import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class DetailsItem extends StatelessWidget {
  String content;
  TextAlign? align;

  DetailsItem({
    super.key,
    required this.content,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimenConstant.padding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: (DimenConstant.extraSmall / 2) - 2.5,
            ),
            child: CircleAvatar(
              backgroundColor: ColorConstant.primary,
              radius: 5,
            ),
          ),
          DimenConstant.separator,
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: ColorConstant.secondaryDark,
                fontSize: DimenConstant.extraSmall,
              ),
              textAlign: align ?? TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
