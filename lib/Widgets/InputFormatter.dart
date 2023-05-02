import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the current text input value
    String text = newValue.text;

    // If the text input is empty, return an empty TextEditingValue
    if (text.isEmpty) {
      return TextEditingValue.empty;
    }

    // If the user is deleting characters, allow it
    if (newValue.selection.baseOffset < oldValue.selection.baseOffset) {
      return newValue;
    }

    // If the user has entered the second digit, insert a colon
    if (text.length == 2 && text[1] != ':') {
      text = text.substring(0, 2) + ':' + text.substring(2);
    }

    // Return the new TextEditingValue with the modified text
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
