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
    defaultValue: '',
  );

  static bool get hasMentorXBaseUrl => mentorXBaseUrl.trim().isNotEmpty;

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

  static final attendanceRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'ATTENDANCE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final walletRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'WALLET_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final notificationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'NOTIFICATION_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final settingsRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'SETTINGS_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final profileRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'PROFILE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final quizRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'QUIZ_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final assignmentRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'ASSIGNMENT_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final aiRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'AI_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final marketplaceRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'MARKETPLACE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final announcementRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'ANNOUNCEMENT_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final rewardsRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'REWARDS_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final gradeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'GRADE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static bool get usesAnyProdRepository =>
      authenticationRepositoryMode == RepositoryMode.prod ||
      homeRepositoryMode == RepositoryMode.prod ||
      courseRepositoryMode == RepositoryMode.prod ||
      attendanceRepositoryMode == RepositoryMode.prod ||
      walletRepositoryMode == RepositoryMode.prod ||
      notificationRepositoryMode == RepositoryMode.prod ||
      settingsRepositoryMode == RepositoryMode.prod ||
      profileRepositoryMode == RepositoryMode.prod ||
      quizRepositoryMode == RepositoryMode.prod ||
      assignmentRepositoryMode == RepositoryMode.prod ||
      aiRepositoryMode == RepositoryMode.prod ||
      marketplaceRepositoryMode == RepositoryMode.prod ||
      announcementRepositoryMode == RepositoryMode.prod ||
      rewardsRepositoryMode == RepositoryMode.prod ||
      gradeRepositoryMode == RepositoryMode.prod;

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
