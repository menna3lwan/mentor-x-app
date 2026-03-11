import 'package:mentorx_core/mentorx_core.dart';

enum RepositoryMode {
  mock,
  prod;

  static RepositoryMode fromString(String value) {
    for (final mode in values) {
      if (mode.name == value.toLowerCase()) {
        return mode;
      }
    }
    // As this is a developer error, we can throw an exception.
    throw Exception('Unknown repository mode: $value');
  }
}

final class Env {
  Env._();

  // Application Configuration
  static const defaultLanguageCode = String.fromEnvironment(
    'DEFAULT_LANGUAGE_CODE',
    defaultValue: 'en',
  );
  static const defaultOtpCodeLength = int.fromEnvironment(
    'DEFAULT_OTP_CODE_LENGTH',
    defaultValue: 6,
  );

  // MentorX Configuration
  static const String mentorXBaseUrl = String.fromEnvironment(
    'MENTORX_API_BASE_URL',
  );

  static final authenticationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'AUTHENTICATION_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final homeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment('HOME_REPOSITORY_MODE', defaultValue: 'mock'),
  );

  static final courseRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'COURSE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  // Mock values:
  static const int _mockDelayDurationInSeconds = int.fromEnvironment(
    'MOCK_DELAY_IN_SECONDS',
    defaultValue: 2,
  );
  static Duration get mockDelayDuration => const Duration(
    seconds: _mockDelayDurationInSeconds,
  );
  static const String mockPhoneNumber = String.fromEnvironment(
    'MOCK_USER_PHONE_NUMBER',
  );
  static const String mockOTP = String.fromEnvironment('MOCK_OTP_CODE');
  static const String mockUserName = String.fromEnvironment('MOCK_USER_NAME');

  static StudentEntity get mockUser => StudentEntity(
    id: 'mockUserId',
    name: mockUserName,
    email: 'mock@email.com',
    phoneNumber: mockPhoneNumber,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
