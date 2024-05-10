import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
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
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.secondaryDark,
            ),
          ),
          Separator(),
          CustomContainer(
            color: ColorConstant.secondaryDark,
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiaryDark,
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
            color: ColorConstant.secondaryDark,
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiaryDark,
            ),
          ),
          Separator(),
          CustomContainer(
            color: ColorConstant.error,
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.secondaryDark,
            ),
          ),
        ],
      ),
      child: CustomContainer(
        width: double.infinity,
        paddingTop: DimenConstant.padding * 1.5,
        paddingBottom: DimenConstant.padding * 1.5,
        border: editing,
        onPressed: onItemPressed,
        child: Text(
          item,
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
