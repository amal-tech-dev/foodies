import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class FoodiesTextField {
  static Widget singleLine({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required int limit,
    FocusNode? focusNode,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.mini,
          ),
        ),
        errorStyle: TextStyle(
          color: ColorConstant.error,
          fontSize: DimenConstant.nano,
          fontFamily: StringConstant.font,
        ),
        suffix: suffix,
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: ColorConstant.primary,
        fontSize: DimenConstant.mini,
      ),
      cursorColor: ColorConstant.secondary,
      cursorRadius: Radius.circular(
        DimenConstant.cursorRadius,
      ),
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit),
        InputFormatController(),
      ],
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  static Widget multiLine({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required int lines,
    required int limit,
    FocusNode? focusNode,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.mini,
          ),
        ),
        errorStyle: TextStyle(
          color: ColorConstant.error,
          fontSize: DimenConstant.nano,
          fontFamily: StringConstant.font,
        ),
        suffix: suffix,
        contentPadding: EdgeInsets.all(0),
        alignLabelWithHint: true,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: ColorConstant.primary,
        fontSize: DimenConstant.mini,
      ),
      cursorColor: ColorConstant.secondary,
      cursorRadius: Radius.circular(
        DimenConstant.cursorRadius,
      ),
      maxLines: lines,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit),
        InputFormatController(),
      ],
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
    );
  }

  static Widget singleLineForm({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required int limit,
    required void Function(String) onSubmit,
    required String? Function(String?) validator,
    FocusNode? focusNode,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.mini,
          ),
        ),
        errorStyle: TextStyle(
          color: ColorConstant.error,
          fontSize: DimenConstant.nano,
          fontFamily: StringConstant.font,
        ),
        suffix: suffix,
        contentPadding: EdgeInsets.all(0),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: ColorConstant.primary,
        fontSize: DimenConstant.mini,
      ),
      cursorColor: ColorConstant.secondary,
      cursorRadius: Radius.circular(
        DimenConstant.cursorRadius,
      ),
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit),
        InputFormatController(),
      ],
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onFieldSubmitted: onSubmit,
      validator: validator,
    );
  }

  static Widget multiLineForm({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required int lines,
    required int limit,
    required String? Function(String?) validator,
    FocusNode? focusNode,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: DimenConstant.mini,
          ),
        ),
        errorStyle: TextStyle(
          color: ColorConstant.error,
          fontSize: DimenConstant.nano,
          fontFamily: StringConstant.font,
        ),
        suffix: suffix,
        contentPadding: EdgeInsets.all(0),
        alignLabelWithHint: true,
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: ColorConstant.primary,
        fontSize: DimenConstant.mini,
      ),
      cursorColor: ColorConstant.secondary,
      cursorRadius: Radius.circular(
        DimenConstant.cursorRadius,
      ),
      maxLines: lines,
      textCapitalization: TextCapitalization.words,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limit),
        InputFormatController(),
      ],
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: validator,
    );
  }
}
