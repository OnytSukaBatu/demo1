import 'package:flutter/services.dart';

class LetterNumber extends TextInputFormatter {
  final RegExp regExp = RegExp(r'[^a-zA-Z0-9]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text.replaceAll(regExp, '');
    return newValue.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}
