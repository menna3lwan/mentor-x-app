import 'package:flutter/services.dart';

/// Formats text input as a phone number (digits only, max length enforced).
///
/// Use with [TextField]'s [inputFormatters] property.
final class PhoneNumberFormatter extends TextInputFormatter {
  final int maxLength;

  const PhoneNumberFormatter({this.maxLength = 13});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length > maxLength) {
      return oldValue;
    }
    return newValue.copyWith(
      text: digitsOnly,
      selection: TextSelection.collapsed(offset: digitsOnly.length),
    );
  }
}
