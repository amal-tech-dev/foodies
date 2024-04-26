import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/separator.dart';

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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.padding * 5,
            ),
            child: Image.asset(
              ImageConstant.chef,
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
                color: ColorConstant.secondaryDark,
                fontSize: DimenConstant.sText,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Separator(),
        ),
        ...children,
      ],
    );
  }
}
