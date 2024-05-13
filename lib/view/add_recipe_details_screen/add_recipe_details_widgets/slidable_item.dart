import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';

class SlidableItem extends StatelessWidget {
  String item;
  bool editing;
  VoidCallback onItemPressed, onEditPressed, onDeletePressed;

  SlidableItem({
    super.key,
    required this.item,
    required this.editing,
    required this.onItemPressed,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: 0,
      closeOnScroll: true,
      startActionPane: ActionPane(
        extentRatio: 0.32,
        motion: ScrollMotion(),
        children: [
          CustomContainer(
            color: ColorConstant.error,
            onPressed: onDeletePressed,
            child: CustomIcon(icon: Icons.delete_rounded),
          ),
          Separator(),
          CustomContainer(
            color: ColorConstant.secondaryLight,
            onPressed: onEditPressed,
            child: CustomIcon(
              icon: Icons.edit_rounded,
              color: ColorConstant.tertiaryLight,
            ),
          ),
          Separator()
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.32,
        motion: ScrollMotion(),
        children: [
          Separator(),
          CustomContainer(
            color: ColorConstant.secondaryLight,
            onPressed: onEditPressed,
            child: CustomIcon(
              icon: Icons.edit_rounded,
              color: ColorConstant.tertiaryLight,
            ),
          ),
          Separator(),
          CustomContainer(
            color: ColorConstant.error,
            onPressed: onDeletePressed,
            child: CustomIcon(icon: Icons.delete_rounded),
          ),
        ],
      ),
      child: CustomContainer(
        width: double.infinity,
        paddingTop: DimenConstant.padding * 1.5,
        paddingBottom: DimenConstant.padding * 1.5,
        border: editing,
        onPressed: onItemPressed,
        child: CustomText(
          text: item,
          size: DimenConstant.xsText,
          align: TextAlign.justify,
        ),
      ),
    );
  }
}
