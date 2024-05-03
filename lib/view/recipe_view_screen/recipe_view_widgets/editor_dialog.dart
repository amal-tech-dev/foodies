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
        contentPadding: const EdgeInsets.symmetric(
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
            limit: 50,
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

  static radio({
    required BuildContext context,
    required String title,
    required String currentValue,
    required List elements,
    required Function(String) save,
  }) async {
    int radioValue = elements.indexOf(currentValue);
    return await showDialog(
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
          height: 200,
          paddingRight: 0,
          child: Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  save(elements[index]);
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        elements[index],
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.xsText,
                        ),
                      ),
                    ),
                    Radio(
                      value: index,
                      groupValue: radioValue,
                      activeColor: ColorConstant.primary,
                      onChanged: (value) {
                        save(elements[index]);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              itemCount: elements.length,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Cancel',
                color: ColorConstant.secondaryDark,
                size: DimenConstant.xsText,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static checkbox({
    required BuildContext context,
    required String title,
    required List currentValues,
    required List elements,
    required Function(List<String>) save,
  }) async {
    List<bool> checkValues = [];
    for (String value in elements) {
      checkValues.add(currentValues.contains(value) ? true : false);
    }
    return await showDialog(
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
          height: 200,
          paddingVertical: 0,
          child: Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        elements[index],
                        style: TextStyle(
                          color: ColorConstant.secondaryDark,
                          fontSize: DimenConstant.xsText,
                        ),
                      ),
                    ),
                    Checkbox(
                      value: checkValues[index],
                      checkColor: ColorConstant.tertiaryDark,
                      activeColor: ColorConstant.primary,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              itemCount: elements.length,
            ),
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
