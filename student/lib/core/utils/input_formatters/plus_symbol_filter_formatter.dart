import 'package:flutter/services.dart';

/// Strips leading '+' characters from phone number input.
///
/// Useful for phone-number fields when the UI area-code selector
/// already provides the country prefix.
final class PlusSymbolFilterFormatter extends TextInputFormatter {
  const PlusSymbolFilterFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.startsWith('+')) return newValue;
    final stripped = newValue.text.replaceAll(RegExp(r'^\++'), '');
    return newValue.copyWith(
      text: stripped,
      selection: TextSelection.collapsed(offset: stripped.length),
    );
  }
}
