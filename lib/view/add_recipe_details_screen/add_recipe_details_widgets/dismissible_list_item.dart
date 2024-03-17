import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/madroid.dart';

class DismissibleListItem extends StatelessWidget {
  String item;
  bool editing;
  VoidCallback onItemPressed, onEditPressed, onDeletePressed;

  DismissibleListItem({
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
          Madroid.container(
            backgroundColor: ColorConstant.error,
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.primary,
            ),
          ),
          DimenConstant.separator,
          Madroid.container(
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiary,
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
          Madroid.container(
            onPressed: onEditPressed,
            child: Icon(
              Icons.edit_rounded,
              color: ColorConstant.tertiary,
            ),
          ),
          DimenConstant.separator,
          Madroid.container(
            backgroundColor: ColorConstant.error,
            onPressed: onDeletePressed,
            child: Icon(
              Icons.delete_rounded,
              color: ColorConstant.primary,
            ),
          ),
        ],
      ),
      child: Madroid.container(
        paddingTop: DimenConstant.padding * 1.5,
        paddingBottom: DimenConstant.padding * 1.5,
        border: editing,
        onPressed: onItemPressed,
        child: Text(
          item,
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.mini,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
