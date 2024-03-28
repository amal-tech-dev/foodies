import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class PageItem extends StatelessWidget {
  String header, image;
  List<Widget> children;

  PageItem({
    super.key,
    required this.header,
    required this.image,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding * 5,
            ),
            child: Image.asset(
              image,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding * 4,
            ),
            child: Text(
              header,
              style: TextStyle(
                color: ColorConstant.primaryDark,
                fontSize: DimenConstant.extraSmall,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: DimenConstant.separator,
        ),
        ...children,
      ],
    );
  }
}
