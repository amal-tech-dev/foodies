import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class CustomTextField {
  static Widget singleLine({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    required int limit,
    required VoidCallback onSubmitted,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          cursorColor: ColorConstant.primary,
          cursorRadius: Radius.circular(
            DimenConstant.cursorRadius,
          ),
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            LengthLimitingTextInputFormatter(limit),
            InputFormatController(),
          ],
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onEditingComplete: onSubmitted,
        ),
      );

  static Widget multiLine({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    required int lines,
    required int limit,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            contentPadding: EdgeInsets.all(0),
            alignLabelWithHint: true,
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          cursorColor: ColorConstant.primary,
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
        ),
      );

  static Widget singleLineForm({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    required int limit,
    required void Function(String) onSubmit,
    required String? Function(String?) validator,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            errorStyle: TextStyle(
              color: ColorConstant.error,
              fontSize: DimenConstant.xxsText,
              fontFamily: StringConstant.font,
            ),
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          cursorColor: ColorConstant.primary,
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
        ),
      );

  static Widget multiLineForm({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    required int lines,
    required int limit,
    required String? Function(String?) validator,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            errorStyle: TextStyle(
              color: ColorConstant.error,
              fontSize: DimenConstant.xxsText,
              fontFamily: StringConstant.font,
            ),
            contentPadding: EdgeInsets.all(0),
            alignLabelWithHint: true,
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          cursorColor: ColorConstant.primary,
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
        ),
      );

  static Widget password({
    required BuildContext context,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onObscureChange,
    required void Function(String?) onFieldSubmitted,
    required String? Function(String?) validator,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            errorStyle: TextStyle(
              color: ColorConstant.error,
              fontSize: DimenConstant.xxsText,
              fontFamily: StringConstant.font,
            ),
            suffix: InkWell(
              onTap: onObscureChange,
              child: Icon(
                obscure
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: ColorConstant.primary,
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
            fontFamily: StringConstant.font,
          ),
          cursorColor: ColorConstant.primary,
          cursorRadius: Radius.circular(
            DimenConstant.cursorRadius,
          ),
          obscureText: obscure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
        ),
      );

  static Widget search({
    required BuildContext context,
    required TextEditingController controller,
    required int limit,
    required VoidCallback onSearchPressed,
    bool? visible,
    FocusNode? focusNode,
  }) =>
      Visibility(
        visible: visible ?? true,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: ColorConstant.secondaryDark.withOpacity(0.5),
              fontSize: DimenConstant.xsText,
            ),
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            suffix: InkWell(
              onTap: onSearchPressed,
              child: Text(
                'Search',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.xsText,
                ),
              ),
            ),
          ),
          style: TextStyle(
            color: ColorConstant.secondaryDark,
            fontSize: DimenConstant.xsText,
          ),
          cursorColor: ColorConstant.primary,
          cursorRadius: Radius.circular(
            DimenConstant.cursorRadius,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(limit),
            InputFormatController(),
          ],
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onEditingComplete: onSearchPressed,
        ),
      );
}
