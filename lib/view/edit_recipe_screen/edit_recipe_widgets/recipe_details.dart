import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeDetails extends StatelessWidget {
  RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    FocusNode descriptionFocusNode = FocusNode();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text(
                  'Name',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.smallText,
                  ),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.smallText,
              ),
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                TextInputFormatController(),
              ],
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onSubmitted: (value) =>
                  FocusScope.of(context).requestFocus(descriptionFocusNode),
            ),
          ),
          DimenConstant.separator,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextField(
              controller: descriptionController,
              focusNode: descriptionFocusNode,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                label: Text(
                  'Description',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.smallText,
                  ),
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.smallText,
              ),
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              maxLines: 5,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
                TextInputFormatController(),
              ],
              textCapitalization: TextCapitalization.sentences,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
          DimenConstant.separator,
          Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: ExpansionTile(
              title: Text(
                'Cuisines',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
