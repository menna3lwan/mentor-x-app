import 'package:mentorx_ui/mentorx_ui.dart';

/// Form-field validators for the parent-app auth flow. All validators accept
/// an optional `BuildContext`-bound translations object so error messages can
/// be localized.
class AuthValidators {
  AuthValidators._();

  /// Egyptian mobile numbers: 11 digits starting with `01`, optionally
  /// prefixed with `+20` or `0020`. Accepts the raw user input (we strip
  /// whitespace + dashes before checking).
  static final RegExp _egyptianPhone = RegExp(
    r'^(?:\+?20|0020)?0?1[0-2,5]\d{8}$',
  );

  /// Strips formatting characters (whitespace, dashes, parens) from a phone
  /// before validation so users can paste any reasonable shape.
  static String _normalizePhone(String raw) {
    return raw.replaceAll(RegExp(r'[\s\-()]+'), '');
  }

  /// Validates Egyptian mobile numbers. Returns `null` when valid, or a
  /// localized error message otherwise.
  static String? phone(String? input, TranslationsParentEn t) {
    if (input == null || input.trim().isEmpty) return t.auth.phoneRequired;
    final normalized = _normalizePhone(input.trim());
    if (!_egyptianPhone.hasMatch(normalized)) {
      // Reuses the existing "phone required" key as a soft message until
      // a dedicated "invalid phone" key is added — keeps copy consistent.
      return t.auth.regErrorInvalidPhone;
    }
    return null;
  }

  /// Plain non-empty validator with a min-length guard. Use for password
  /// fields where the backend enforces complexity rules separately.
  static String? password(
    String? input,
    TranslationsParentEn t, {
    int minLength = 6,
  }) {
    if (input == null || input.isEmpty) return t.auth.passwordRequired;
    if (input.length < minLength) {
      // Backend ultimately enforces strength — we just stop empty/too-short
      // submissions on the client.
      return t.auth.passwordRequired;
    }
    return null;
  }

  /// OTP must be exactly the requested digit count (default 6).
  static String? otp(String? input, {int length = 6}) {
    if (input == null || input.isEmpty) return 'required';
    if (input.length != length) return 'length';
    if (!RegExp(r'^\d+$').hasMatch(input)) return 'format';
    return null;
  }
}
