import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

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
            backgroundColor: ColorConstant.error,
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.primaryDark,
            ),
          ),
          DimenConstant.separator,
          CustomContainer(
            backgroundColor: ColorConstant.primaryDark,
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiaryDark,
            ),
          ),
          DimenConstant.separator
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.32,
        motion: ScrollMotion(),
        children: [
          DimenConstant.separator,
          CustomContainer(
            backgroundColor: ColorConstant.primaryDark,
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiaryDark,
            ),
          ),
          DimenConstant.separator,
          CustomContainer(
            backgroundColor: ColorConstant.error,
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.primaryDark,
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
            color: ColorConstant.primaryDark,
            fontSize: DimenConstant.mini,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
