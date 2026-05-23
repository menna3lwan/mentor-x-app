import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/features/auth/utils/auth_validators.dart';

/// Pulls the real TranslationsParentEn instance via the Slang provider so
/// tests share the same copy with the app.
TranslationsParentEn _t() {
  // Slang's TranslationProvider returns a `Translations` root which has the
  // `parent` sub-tree. We access the EN variant directly for deterministic
  // assertions.
  return Translations.buildLocale(AppLocale.en).parent;
}

void main() {
  late TranslationsParentEn t;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    t = _t();
  });

  group('AuthValidators.phone', () {
    test('empty input returns required error', () {
      expect(AuthValidators.phone('', t), equals(t.auth.phoneRequired));
      expect(AuthValidators.phone(null, t), equals(t.auth.phoneRequired));
      expect(AuthValidators.phone('   ', t), equals(t.auth.phoneRequired));
    });

    test('accepts canonical Egyptian mobile numbers', () {
      expect(AuthValidators.phone('01001234567', t), isNull);
      expect(AuthValidators.phone('01112345678', t), isNull);
      expect(AuthValidators.phone('01512345678', t), isNull);
      expect(AuthValidators.phone('01212345678', t), isNull);
    });

    test('accepts +20 / 0020 prefixes', () {
      expect(AuthValidators.phone('+201001234567', t), isNull);
      expect(AuthValidators.phone('00201001234567', t), isNull);
    });

    test('rejects malformed phones', () {
      // Wrong length.
      expect(AuthValidators.phone('012345', t), isNotNull);
      // Doesn't start with valid carrier digit (01 + 0/1/2/5).
      expect(AuthValidators.phone('01342345678', t), isNotNull);
      // Non-digit garbage.
      expect(AuthValidators.phone('abcdefghijk', t), isNotNull);
    });

    test('tolerates whitespace / dashes / parens in input', () {
      expect(AuthValidators.phone('010 0123 4567', t), isNull);
      expect(AuthValidators.phone('010-0123-4567', t), isNull);
      expect(AuthValidators.phone('(010) 0123 4567', t), isNull);
    });
  });

  group('AuthValidators.password', () {
    test('empty returns required error', () {
      expect(AuthValidators.password('', t), equals(t.auth.passwordRequired));
      expect(
        AuthValidators.password(null, t),
        equals(t.auth.passwordRequired),
      );
    });

    test('too-short password fails', () {
      expect(AuthValidators.password('abc', t), isNotNull);
    });

    test('accepts any 6+ character password', () {
      expect(AuthValidators.password('abcdef', t), isNull);
      expect(AuthValidators.password('a-strong-secret', t), isNull);
    });
  });

  group('AuthValidators.otp', () {
    test('rejects empty / wrong length / non-digit', () {
      expect(AuthValidators.otp(''), isNotNull);
      expect(AuthValidators.otp('12345'), isNotNull); // too short
      expect(AuthValidators.otp('1234567'), isNotNull); // too long (max-limit)
      expect(AuthValidators.otp('12345a'), isNotNull); // non-digit
    });

    test('accepts a clean 6-digit code', () {
      expect(AuthValidators.otp('123456'), isNull);
    });

    test('respects custom length', () {
      expect(AuthValidators.otp('1234', length: 4), isNull);
      expect(AuthValidators.otp('123456', length: 4), isNotNull);
    });
  });
}
