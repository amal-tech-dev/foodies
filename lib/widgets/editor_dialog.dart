import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/separator.dart';

class EditorDialog {
  static text({
    required BuildContext context,
    required String title,
    required String content,
    required Function(String) save,
  }) async {
    TextEditingController controller = TextEditingController(text: content);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorConstant.backgroundDark,
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(
          vertical: DimenConstant.padding * 2,
          horizontal: DimenConstant.padding,
        ),
        title: CustomText(
          text: 'Edit $title',
          color: ColorConstant.primary,
          size: DimenConstant.sText,
        ),
        content: CustomContainer(
          paddingVertical: 0,
          child: CustomTextField.singleLine(
            context: context,
            hint: 'Edit $title',
            controller: controller,
            limit: 20,
            onSubmitted: () {
              save(controller.text.trim());
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          CustomText(
            text: 'Cancel',
            color: ColorConstant.secondaryDark,
            size: DimenConstant.xsText,
            onPressed: () => Navigator.pop(context),
          ),
          Separator(),
          CustomText(
            text: 'Save',
            color: ColorConstant.primary,
            size: DimenConstant.xsText,
            onPressed: () {
              save(controller.text.trim());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
