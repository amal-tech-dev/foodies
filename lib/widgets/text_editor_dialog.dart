import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/custom_text_field.dart';

import 'separator.dart';

class TextEditorDialog {
  static editor({
    required BuildContext context,
    required String text,
    required Function(String) save,
  }) async {
    TextEditingController controller = TextEditingController(text: text);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorConstant.backgroundDark,
        content: CustomContainer(
          padding: DimenConstant.padding,
          backgroundColor: ColorConstant.backgroundDark,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Edit',
                color: ColorConstant.primary,
                size: DimenConstant.sText,
              ),
              Separator(),
              CustomContainer(
                paddingVertical: 0,
                child: CustomTextField.singleLine(
                  context: context,
                  hint: 'Edit',
                  controller: controller,
                  limit: 20,
                  onSubmitted: () => FocusScope.of(context).unfocus(),
                ),
              ),
              Separator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton.text(
                    text: 'Cancel',
                    textColor: ColorConstant.secondaryDark,
                    background: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                  ),
                  CustomButton.text(
                    text: 'Save',
                    textColor: ColorConstant.primary,
                    background: Colors.transparent,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    save(controller.text.trim());
  }
}
