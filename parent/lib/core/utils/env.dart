
enum RepositoryMode { mock, prod }

final class Env {
  Env._();

  static const String mentorXBaseUrl = String.fromEnvironment(
    'MENTORX_API_BASE_URL',
    defaultValue: 'https://api.mentorx.com',
  );

  static const bool hasMentorXBaseUrl = mentorXBaseUrl != '';

  static const RepositoryMode authenticationRepositoryMode =
      RepositoryMode.mock; // Default to mock for now
  static const RepositoryMode homeRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode childrenRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode financialRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode courseRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode attendanceRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode gradeRepositoryMode = RepositoryMode.mock;
  static const RepositoryMode communicationRepositoryMode = RepositoryMode.mock;

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
