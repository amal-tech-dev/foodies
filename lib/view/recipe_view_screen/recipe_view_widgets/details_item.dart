import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class DetailsItem extends StatelessWidget {
  String content;
  DetailsItem({
    super.key,
    required this.content,
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
              backgroundColor: ColorConstant.secondary,
              radius: 5,
            ),
          ),
          DimenConstant.separator,
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: DimenConstant.extraSmall,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
