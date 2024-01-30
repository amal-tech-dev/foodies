import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class DismissibleListItem extends StatelessWidget {
  String item;
  bool isEditing;
  VoidCallback onItemPressed, onEditPressed, onDeletePressed;

  DismissibleListItem({
    super.key,
    required this.item,
    required this.isEditing,
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
          InkWell(
            onTap: onDeletePressed,
            child: Container(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.errorColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Icon(
                Icons.delete_rounded,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
          DimenConstant.separator,
          InkWell(
            onTap: onEditPressed,
            child: Container(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.secondaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Icon(
                Icons.edit_rounded,
                color: ColorConstant.tertiaryColor,
              ),
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
          InkWell(
            onTap: onEditPressed,
            child: Container(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.secondaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Icon(
                Icons.edit_rounded,
                color: ColorConstant.tertiaryColor,
              ),
            ),
          ),
          DimenConstant.separator,
          InkWell(
            onTap: onDeletePressed,
            child: Container(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.errorColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Icon(
                Icons.delete_rounded,
                color: ColorConstant.primaryColor,
              ),
            ),
          ),
        ],
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onItemPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: DimenConstant.edgePadding * 1.5,
            horizontal: DimenConstant.edgePadding,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            border: Border.all(
              color:
                  isEditing ? ColorConstant.secondaryColor : Colors.transparent,
              width: DimenConstant.borderWidth,
            ),
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: Text(
            item,
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.miniText,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
