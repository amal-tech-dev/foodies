import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_dialog.dart';
import 'package:foodies/widgets/custom_scaffold_messenger.dart';
import 'package:foodies/widgets/custom_text_field.dart';

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
      builder: (context) => CustomDialog(
        paddingHorizontal: DimenConstant.padding,
        title: 'Edit $title',
        contentWidget: CustomContainer(
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
        positiveText: 'Save',
        onPositivePressed: () {
          if (controller.text.trim().isEmpty) {
            CustomScaffoldMessenger.snackBar(
              context: context,
              content: 'Text is empty',
            );
          } else {
            save(controller.text.trim());
            Navigator.pop(context);
          }
        },
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
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => CustomDialog(
          paddingHorizontal: DimenConstant.padding,
          title: 'Edit $title',
          contentWidget: CustomContainer(
            height: 200,
            paddingRight: 0,
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  radioValue = index;
                  setState(() {});
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
                        radioValue = index;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              itemCount: elements.length,
            ),
          ),
          positiveText: 'Save',
          onPositivePressed: () {
            save(elements[radioValue]);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  static checkbox({
    required BuildContext context,
    required String title,
    required List<String> currentValues,
    required List elements,
    required Function(List<String>) save,
  }) async {
    List<bool> checkValues = [];
    for (String value in elements) {
      checkValues.add(currentValues.contains(value) ? true : false);
    }
    return await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => CustomDialog(
          paddingHorizontal: DimenConstant.padding,
          title: 'Edit $title',
          contentWidget: CustomContainer(
            height: 200,
            paddingVertical: 0,
            child: ListView.builder(
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  checkValues[index] = !checkValues[index];
                  currentValues = [];
                  for (int i = 0; i < checkValues.length; i++) {
                    if (checkValues[i]) currentValues.add(elements[i]);
                  }
                  setState(() {});
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
                    Checkbox(
                      value: checkValues[index],
                      checkColor: ColorConstant.tertiaryDark,
                      activeColor: ColorConstant.primary,
                      onChanged: (value) {
                        checkValues[index] = !checkValues[index];
                        currentValues = [];
                        for (int i = 0; i < checkValues.length; i++) {
                          if (checkValues[i]) currentValues.add(elements[i]);
                        }
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              itemCount: elements.length,
            ),
          ),
          positiveText: 'Save',
          onPositivePressed: () {
            if (currentValues.isEmpty) {
              CustomScaffoldMessenger.snackBar(
                context: context,
                content: 'No categories selected',
              );
            } else {
              save(currentValues);
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
