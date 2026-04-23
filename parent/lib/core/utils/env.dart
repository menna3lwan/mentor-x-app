
import 'package:mentorx_core/mentorx_core.dart';

final class Env {
  Env._();

  static const String mentorXBaseUrl = String.fromEnvironment(
    'MENTORX_API_BASE_URL',
    defaultValue: 'https://api.mentorx.com',
  );

  static const bool hasMentorXBaseUrl = mentorXBaseUrl != '';

  static final authenticationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'AUTHENTICATION_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final homeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'HOME_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final childrenRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'CHILDREN_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final financialRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'FINANCIAL_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
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

  static final gradeRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'GRADE_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static final communicationRepositoryMode = RepositoryMode.fromString(
    const String.fromEnvironment(
      'COMMUNICATION_REPOSITORY_MODE',
      defaultValue: 'mock',
    ),
  );

  static const Duration mockDelayDuration = Duration(milliseconds: 800);

  static const String defaultLanguageCode = 'ar';

  static bool get usesAnyProdRepository =>
      authenticationRepositoryMode == RepositoryMode.prod ||
      homeRepositoryMode == RepositoryMode.prod ||
      childrenRepositoryMode == RepositoryMode.prod ||
      financialRepositoryMode == RepositoryMode.prod ||
      courseRepositoryMode == RepositoryMode.prod ||
      attendanceRepositoryMode == RepositoryMode.prod ||
      gradeRepositoryMode == RepositoryMode.prod ||
      communicationRepositoryMode == RepositoryMode.prod;
}
