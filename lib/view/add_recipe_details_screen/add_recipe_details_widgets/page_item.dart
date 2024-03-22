import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class PageItem extends StatelessWidget {
  String header;
  List<Widget> children;

  PageItem({
    super.key,
    required this.header,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenConstant.padding * 4,
          ),
          child: Text(
            header,
            style: TextStyle(
              color: ColorConstant.primary,
              fontSize: DimenConstant.extraSmall,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        DimenConstant.separator,
        ...children,
      ],
    );
  }
}
