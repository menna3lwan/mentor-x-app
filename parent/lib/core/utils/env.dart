enum RepositoryMode {
  mock,
  prod;

  static RepositoryMode fromString(String value) {
    for (final mode in values) {
      if (mode.name == value.toLowerCase()) return mode;
    }
    return RepositoryMode.mock;
  }
}

final class Env {
  Env._();

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
  static final authenticationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment('AUTHENTICATION_REPOSITORY_MODE',
        defaultValue: 'mock'),
  );

  static final dashboardRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment('DASHBOARD_REPOSITORY_MODE',
        defaultValue: 'mock'),
  );

  // ──── Mock Configuration ────
  static const int _mockDelayDurationInSeconds = int.fromEnvironment(
    'MOCK_DELAY_IN_SECONDS',
    defaultValue: 2,
  );
  static Duration get mockDelayDuration =>
      const Duration(seconds: _mockDelayDurationInSeconds);

  static const String mockPhoneNumber =
      String.fromEnvironment('MOCK_USER_PHONE_NUMBER');
  static const String mockOTP = String.fromEnvironment('MOCK_OTP_CODE');
  static const String mockUserName = String.fromEnvironment('MOCK_USER_NAME');
}
