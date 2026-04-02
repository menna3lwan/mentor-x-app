enum RepositoryMode {
  mock,
  prod;

  static RepositoryMode fromString(String value) {
    for (final mode in values) {
      if (mode.name == value.toLowerCase()) return mode;
    }
    throw ArgumentError(
      'Unknown RepositoryMode: "$value". Must be mock or prod.',
    );
  }
}

final class Env {
  Env._();

  static bool get hasMentorxBaseUrl => mentorxBaseUrl.trim().isNotEmpty;

  // ──── Application Constants ────
  static const defaultLanguageCode = String.fromEnvironment(
    'DEFAULT_LANGUAGE_CODE',
    defaultValue: 'en',
  );
  static const defaultOtpCodeLength = int.fromEnvironment(
    'DEFAULT_OTP_CODE_LENGTH',
    defaultValue: 6,
  );
  static const minPhoneNumberLength = int.fromEnvironment(
    'MIN_PHONE_NUMBER_LENGTH',
    defaultValue: 11,
  );
  static const maxPhoneNumberLength = int.fromEnvironment(
    'MAX_PHONE_NUMBER_LENGTH',
    defaultValue: 13,
  );

  // ──── API Configuration ────
  static const String mentorxBaseUrl = String.fromEnvironment(
    'MENTORX_API_BASE_URL',
  );
  static const String mentorxApiKey = String.fromEnvironment(
    'MENTORX_API_KEY',
  );

  // ──── Per-Repository Mode Switches ────
  /// `AUTHENTICATION_REPOSITORY_MODE` must be `mock` or `prod` in dev.env.
  static final authenticationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'AUTHENTICATION_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final dashboardRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'DASHBOARD_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static bool get usesAnyProdRepository {
    return authenticationRepositoryMode == RepositoryMode.prod ||
        dashboardRepositoryMode == RepositoryMode.prod;
  }

  // ──── Mock Configuration ────
  static const int _mockDelayInSeconds = int.fromEnvironment(
    'MOCK_DELAY_IN_SECONDS',
    defaultValue: 2,
  );
  static Duration get mockDelayDuration =>
      Duration(seconds: _mockDelayInSeconds);

  static const String mockUserPhone = String.fromEnvironment(
    'MOCK_USER_PHONE_NUMBER',
    defaultValue: '01000000000',
  );
  static const String mockOtpCode = String.fromEnvironment(
    'MOCK_OTP_CODE',
    defaultValue: '123456',
  );
  static const String mockUserName = String.fromEnvironment(
    'MOCK_USER_NAME',
    defaultValue: 'Parent Account',
  );
}
