import 'package:flutter/services.dart';

class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final regExp = RegExp(
      r'^\+?[0-9]*$',
    ); // Allow + only at the start and digits everywhere
    if (regExp.hasMatch(newValue.text)) {
      // Ensure there's only one "+" at the start
      if (newValue.text.indexOf('+') > 0) {
        return oldValue; // Reject input if "+" appears elsewhere
      }
      return newValue; // Accept valid input
    }
    return oldValue; // Reject invalid input
  }
}
