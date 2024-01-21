import 'package:flutter/services.dart';

class TextInputFormatController extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty &&
        newValue.text.substring(newValue.text.length - 1) == '.') {
      if (newValue.text.length > oldValue.text.length) {
        return TextEditingValue(
          text: '${newValue.text} ',
          selection: TextSelection.collapsed(
            offset: newValue.selection.end + 1,
          ),
        );
      } else if (newValue.text.length < oldValue.text.length) {
        final newString = newValue.text;
        final cursorIndex = newValue.selection.baseOffset;
        if (cursorIndex > 0 &&
            newString.length >= cursorIndex &&
            newString[cursorIndex - 1] == ' ') {
          final updatedString = newString.substring(0, cursorIndex - 1) +
              newString.substring(cursorIndex);
          return TextEditingValue(
            text: updatedString,
            selection: TextSelection.collapsed(
              offset: cursorIndex - 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
