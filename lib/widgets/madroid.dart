import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class Madroid {
  static Widget appName({
    required double size,
  }) {
    return Row(
      children: [
        Text(
          StringConstant.appNamePrefix,
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: size,
            fontFamily: StringConstant.font,
          ),
        ),
        Text(
          StringConstant.appNameSuffix,
          style: TextStyle(
            color: ColorConstant.secondary,
            fontSize: size,
            fontFamily: StringConstant.font,
          ),
        ),
      ],
    );
  }

  static Widget container({
    double? paddingTop,
    double? paddingLeft,
    double? paddingRight,
    double? paddingBottom,
    double? borderRadius,
    bool? border,
    Color? backgroundColor,
    VoidCallback? onPressed,
    required Widget child,
  }) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        padding: EdgeInsets.only(
          top: paddingTop ?? DimenConstant.padding,
          left: paddingLeft ?? DimenConstant.padding,
          right: paddingRight ?? DimenConstant.padding,
          bottom: paddingBottom ?? DimenConstant.padding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorConstant.tertiary,
          borderRadius: BorderRadius.circular(
            borderRadius ?? DimenConstant.borderRadius,
          ),
          border: border ?? false
              ? Border.all(
                  color: ColorConstant.secondary,
                  width: DimenConstant.borderWidth,
                )
              : Border.all(
                  width: 0.0,
                ),
        ),
        child: child,
      ),
    );
  }

  static Widget button({
    required VoidCallback onPressed,
    required Widget child,
    Color? background,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
    Color? background,
  }) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? ColorConstant.tertiary,
          fontSize: DimenConstant.mini,
        ),
      ),
    );
  }

  static Widget iconButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color? iconColor,
    Color? background,
  }) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? ColorConstant.secondary,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor ?? ColorConstant.tertiary,
      ),
    );
  }

  static Widget backButton({
    Color? iconColor,
    Color? background,
  }) {
    return BackButton(
      color: iconColor ?? ColorConstant.primary,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          background ?? Colors.transparent,
        ),
      ),
    );
  }

  static Widget singleLineTextField({
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

  static Widget multiLineTextField({
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

  static Widget singleLineTextFormField({
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

  static Widget multiLineTextFormField({
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
